provider "aws" {
#    access_key = "${var.aws_access_key}"
#    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
}

module "instances" {
  source = "./modules/instances"
  vpcid = "${module.vpc.vpcid}"
  public_subnet_id = "${module.vpc.publicid}"
  private_subnet_id = "${module.vpc.privateid}"
  organization_ip = "103.6.32.0/24"
  vpc_cidr = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
}

