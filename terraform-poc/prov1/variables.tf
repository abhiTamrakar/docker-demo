#variable "aws_access_key" {}
#variable "aws_secret_key" {}
variable "aws_key_path" {}
variable "aws_key_name" {}

variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "us-east-2"
}

variable "amis" {
    description = "AMIs by region"
    default = {
        us-east-2 = "ami-0552e3455b9bc8d50" # ubuntu 16.04 LTS
    }
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
    description = "CIDR for the Private Subnet"
    default = "10.0.2.0/24"
}

variable "orgip" {
    description = "IP address cidr for your organization"
    default = "103.6.32.0/24" #some value
}

variable "jenkinsip" {
    description = "IP address of the jenkins machine"
    default = "18.223.141.249/32" #some value
}
