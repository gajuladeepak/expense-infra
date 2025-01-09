data "aws_ssm_parameter" "mysql_sg_id" {
  # /expense/dev/mysql_sg_id  #i want name in this format
  name  = "/${var.project_name}/${var.environment}/mysql_sg_id"
}

data "aws_ssm_parameter" "database_subnet_group_name" {
  # /expense/dev/mysql_sg_id  #i want name in this format
  name  = "/${var.project_name}/${var.environment}/database_subnet_group_name"
}


# data "aws_ssm_parameter" "public_subnet_ids" {  #this will return us string list #we can't do our operation on string_list we need to convert string list to list
#   # /expense/dev/bastion_sg_id  #i want name in this format
#   name  = "/${var.project_name}/${var.environment}/public_subnet_ids"
# }

# data "aws_ami" "joindevops" {
#   most_recent      = true
#   owners           = ["973714476881"]  #owner account id 

#   #with only above two lines I will get all the recent AMI's from joindevops

#   filter {
#     name   = "name"
#     values = ["RHEL-9-DevOps-Practice"]  #AMI name

#   }

#   #with the starting two lines and with above block I will get all the recent AMI's from joindevops with name RHEL-9-DevOps-Practice

#   filter {
#     name   = "root-device-type"
#     values = ["ebs"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

# }#to get the owner id click on RHEL-9_DevOps-Practice AMI ID link("ami-09c83fb71547c4f") copy owner account ID