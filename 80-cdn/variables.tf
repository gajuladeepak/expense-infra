variable "project_name" {
    default = "expense"
}

variable "environment" {
    default = "dev"
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "common_tags" {
    default = {
        Project = "expense",
        Terraform = "true",
        Environment = "Dev"
    }
}

variable "frontend_tags" {
    default = {
        Component = "frontend"
    }
}

variable "zone_name" {
    default = "deepakaws.online"
}

