/*
  Web Servers
*/
resource "aws_security_group" "demo2_rorsg" {
    name = "demo2_rorsg"
    description = "Allow incoming HTTP connections."

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["${var.organization_ip}"]
    }
    ingress {
        from_port = 9200
        to_port = 9200
        protocol = "tcp"
        cidr_blocks = ["${var.vpc_cidr}"]
    }
    ingress {
        from_port = 5601
        to_port = 5601
        protocol = "tcp"
        cidr_blocks = ["${var.organization_ip}"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["${var.organization_ip}"]
    }
    egress { # MySQL
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["${var.private_subnet_cidr}"]
    }
    egress {
        from_port = 24224
        to_port = 24224
        protocol = "tcp"
        cidr_blocks = ["${var.private_subnet_cidr}"]
    }	

    vpc_id = "${var.vpcid}"

    tags {
        Name = "WebServerSG demo2"
    }
}

resource "aws_instance" "demo2_rorapp" {
    ami = "${lookup(var.amis, var.aws_region)}"
    availability_zone = "us-east-2a"
    instance_type = "t2.micro"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.demo2_rorsg.id}"]
    subnet_id = "${var.publicid}"
    associate_public_ip_address = true
    source_dest_check = false

    tags {
        Name = "ROR app demo2"
    }
    user_data = <<HEREDOC
#!/bin/bash
apt-get update && \
apt-get install wget apt-transport-https -y && \
wget https://packages.chef.io/files/stable/chef/14.4.56/ubuntu/16.04/chef_14.4.56-1_amd64.deb && \
dpkg -i chef_14.4.56-1_amd64.deb
HEREDOC
}

resource "aws_eip" "demo2_roreip" {
    instance = "${aws_instance.demo2_rorapp.id}"
    vpc = true
}
