data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/${var.environment}/vpc_id"
}


data "aws_ssm_parameter" "public_subnet_ids" {  #this will return us string list #we can't do our operation on string_list we need to convert string list to list
  # /expense/dev/private_subnet_ids  #i want name in this format
  name  = "/${var.project_name}/${var.environment}/public_subnet_ids"
}


data "aws_ssm_parameter" "ingress_alb_sg_id" {
  name = "/${var.project_name}/${var.environment}/ingress_alb_sg_id"
}



data "aws_ssm_parameter" "https_certificate_arn" {  #this will return us string list #we can't do our operation on string_list we need to convert string list to list
  # /expense/dev/app_alb_sg_id  #i want name in this format
  name  = "/${var.project_name}/${var.environment}/https_certificate_arn"
}