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
        from_port = 9100
        to_port = 9100
        protocol = "tcp"
        cidr_blocks = ["${var.private_cidr}"]
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
        cidr_blocks = ["${var.private_cidr}"]
    }
    egress {
        from_port = 24224
        to_port = 24224
        protocol = "tcp"
        cidr_blocks = ["${var.private_cidr}"]
    }	
    egress {
        from_port = 9200
        to_port = 9200
        protocol = "tcp"
        cidr_blocks = ["${var.private_cidr}"]
    }
    egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${var.vpc_id}"

    tags {
        Name = "WebServerSG demo2"
    }
}

resource "aws_instance" "demo2_rorapp" {
    ami = "${var.amiid}"
    availability_zone = "us-east-2a"
    instance_type = "t2.micro"
    key_name = "${var.ssh_key}"
    vpc_security_group_ids = ["${aws_security_group.demo2_rorsg.id}"]
    subnet_id = "${var.public_subnet_id}"
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
