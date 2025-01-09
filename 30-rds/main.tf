module "db" { #this module is taken from terraform aws rds(from internet)
  source = "terraform-aws-modules/rds/aws"

  identifier = local.resource_name #expense-dev #database name(DB instance identifer in UI)

  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 5

  db_name  = "transactions"
  manage_master_user_password = false
  password = "ExpenseApp1"
  username = "root" #(Master username in UI)
  port     = "3306"

  

  vpc_security_group_ids = [local.mysql_sg_id]
  skip_final_snapshot = true


  tags = merge(
    var.common_tags,
    var.rds_tags
  )

  # DB subnet group
  db_subnet_group_name = local.database_subnet_group_name

  # DB parameter group
  family = "mysql8.0"

  # DB option group
  major_engine_version = "8.0"


  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
}

#session 35
module "records" { #taken from internet from aws_route53 module
  source  = "terraform-aws-modules/route53/aws//modules/records"

  zone_name = var.zone_name
  records = [
    {
      name    = "mysql-${var.environment}" #mysql-dev.deepakaws.online
      type    = "CNAME"
      ttl     = 1
      records = [
        module.db.db_instance_address
      ]

      allow_overwrite = true
    }
  ]

}