variable "vpcid" {
}

variable "region" {
}

variable "private_subnet_id" {
}

variable "public_subnet_ids" {
}

variable "public_subnet_id" {
}

variable "public_key_path" {
  description = <<DESCRIPTION
Path to the SSH public key to be used for authentication.
Ensure this keypair is added to your local SSH agent so provisioner can
connect.
Example: ~/.ssh/terraform.pub
DESCRIPTION
}

variable "key_name" {
  description = "Desired name of AWS key pair"
}

# replace the value here by another ami, current is ubuntu trusty
variable "aws_amis" {
  default = {
    us-east-2 = "ami-0552e3455b9bc8d50"
}
}

variable "instance_size" {
  default = "t2.micro"
}
