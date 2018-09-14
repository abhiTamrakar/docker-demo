provider "aws" {
#    access_key = "${var.aws_access_key}"
#    secret_key = "${var.aws_secret_key}"
     region = "${var.aws_region}"
}

module "vpc" {
  source = "./modules/vpc"
  vpccidr = "${var.vpc_cidr}"
  public_cidr = "${var.public_subnet_cidr}"
  private_cidr = "${var.private_subnet_cidr}"
  ssh_key = "${var.aws_key_name}"
  organization_ip = "${var.orgip}"
  jenkins_ip = "${var.jenkinsip}"
}

module "instances" {
  source = "./modules/instances"
  vpc_id = "${module.vpc.vpcid}"
  ssh_key = "${var.aws_key_name}"
  public_subnet_id = "${module.vpc.publicid}"
  private_subnet_id = "${module.vpc.privateid}"
  amiid = "${lookup(var.amis, var.aws_region)}"
  organization_ip = "${var.orgip}"
  vpccidr = "${var.vpc_cidr}"
  private_cidr = "${var.private_subnet_cidr}"
}

#output

output "nat_endpoint" {
   value = "${module.vpc.natip}"
}

output "app_pubendpoint" {
   value = "${module.instances.ror_ip}"
}

output "app_privendpoint" {
   value = "${module.instances.ror_privip}"
}

output "db_endpoint" {
   value = "${module.instances.db_ip}"
}
