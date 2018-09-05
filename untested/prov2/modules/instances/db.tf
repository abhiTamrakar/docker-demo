/*
  Database Servers
*/
resource "aws_security_group" "demo2_dbsg" {
    name = "demo2_dbsg"
    description = "Allow incoming database connections."

    ingress { # MySQL
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = ["${var.vpc_cidr}"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.vpc_cidr}"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["${var.vpc_cidr}"]
    }
    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${var.vpcid}"

    tags {
        Name = "DB server sg demo2"
    }
}

resource "aws_instance" "demo2_db_instance" {
    ami = "${lookup(var.amis, var.aws_region)}"
    availability_zone = "us-east-2a"
    instance_type = "t2.medium"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.demo2_dbsg.id}"]
    subnet_id = "${var.privateid}"
    source_dest_check = false

    tags {
        Name = "DB server instance demo2"
    }

    user_data = <<HEREDOC
#!/bin/bash
apt-get update && \
apt-get install wget apt-transport-https -y && \
wget https://packages.chef.io/files/stable/chef/14.4.56/ubuntu/16.04/chef_14.4.56-1_amd64.deb && \
dpkg -i chef_14.4.56-1_amd64.deb
service ssh status
HEREDOC
}
