variable "project_name" {
    default = "expense"
}

variable "environment" {
    default = "dev"
}

variable "common_tags" {
    default = {
        Project = "expense"
        Terraform = "true"
        Environment = "dev"
    }
}


variable "zone_name" {
    default = "deepakaws.online"
}

variable "zone_id" {
    default = "Z04665842HM6QAD0S0KW"
}