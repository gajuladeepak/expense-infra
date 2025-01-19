resource "aws_key_pair" "eks" {
  key_name   = "eks"
  # you can paste the public key directly like this
  #public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL6ONJth+DzeXbU3oGATxjVmoRjPepdl7sBuPzzQT2Nc sivak@BOOK-I6CR3LQ85Q"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDSaoAhw1frsX0ZKNhJcOvNtFtsSh87pWt3ol70bXH6eAAtBwsMtWf8hLMCiwcjdl3GgWF2F54FXXASiFcqFB0z2A4usPwb3wOReAmNqqq+2lJKKA7t3601tM7Sb0UpB4TeAkO37oGkU+/JLJhwAZN+WlLLGH2+UvPERRYZdviokNisBY32EtN6Ll7tuxa52cMa58BUtLTI/J2bHw3pU0bK8jCnSdDkGrrsFyXKFXQ5n1ln3wJUxDFrB3RnvQVy+nrNAjJYA0EvCwoairEfrwGN15PEvNDaBPPkA0nBLp5e6ZENw2BLVuWQhEgHD29On+iF4Bs+d6PyckQeUfGMxCDrL6iHqsRXmFV/Ag/Cw6PKx7ukcDp3A9sCVnY/fFcGfeZs4cpeBnxB+aQNTg7lHk6/EY6ZvrSE79JMGLWnh2DEHJ/zWH92mm2WnrOZ1Qe0PnvQOn1aJvut0eP2k9lmPoWb3THaM2oNft/p4ijE4rxDZqXQ9oW3evvJujsHj353fIAfuEWPhl2gqVRdjNli1cyg3PVMJpWI7k1aAZmS9h/DnwEh8CFg6YF66KiOUjOi8aDxkq78XJ5uxswUNjsLO0N3+DgrccagTFUKY+BxOfoehvnAgzolN7zZaKZnnp6+ojbnvWl2o0beZlihzBWIBLhb28yGTBm/Ry50iwU5h85+Ew== Deepak Gajula@LAPTOP-P4QC13H3"
  # ~ means windows home directory
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"


  cluster_name    = "${var.project_name}-${var.environment}"
  cluster_version = "1.31"

  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  vpc_id                   = data.aws_ssm_parameter.vpc_id.value
  subnet_ids               = local.private_subnet_ids
  control_plane_subnet_ids = local.private_subnet_ids

  create_cluster_security_group = false
  cluster_security_group_id     = local.eks_control_plane_sg_id

  create_node_security_group = false
  node_security_group_id     = local.node_sg_id

  # the user which you used to create cluster will get admin access

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["m6i.large", "m5.large", "m5n.large", "m5zn.large"]
  }

  eks_managed_node_groups = {
    # blue = {
    #   min_size      = 2
    #   max_size      = 10
    #   desired_size  = 2
    #   #capacity_type = "SPOT"
    #   iam_role_additional_policies = {
    #     AmazonEBSCSIDriverPolicy          = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
    #     AmazonElasticFileSystemFullAccess = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
    #     ElasticLoadBalancingFullAccess = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
    #   }
    #   # EKS takes AWS Linux 2 as it's OS to the nodes
    #   key_name = aws_key_pair.eks.key_name
    # }
    green = {
      min_size      = 2
      max_size      = 10
      desired_size  = 2
      capacity_type = "SPOT"
      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy          = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
        AmazonElasticFileSystemFullAccess = "arn:aws:iam::aws:policy/AmazonElasticFileSystemFullAccess"
        ElasticLoadBalancingFullAccess = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"

      }
      key_name = aws_key_pair.eks.key_name
    }
  }

  # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true

  tags = var.common_tags
}