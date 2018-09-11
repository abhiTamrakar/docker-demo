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
        cidr_blocks = ["${var.vpccidr}"]
    }
    ingress { # fluentd
        from_port = 24224
        to_port = 24224
        protocol = "tcp"
        cidr_blocks = ["${var.vpccidr}"]
    }
    ingress {
        from_port = 9200
        to_port = 9200
        protocol = "tcp"
        cidr_blocks = ["${var.vpccidr}"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.vpccidr}"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["${var.vpccidr}"]
    }
    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 5601
        to_port = 5601
        protocol = "tcp"
        cidr_blocks = ["${var.vpccidr}"]
    }

    vpc_id = "${var.vpc_id}"

    tags {
        Name = "Data server sg demo2"
    }
}

resource "aws_instance" "demo2_db_instance" {
    ami = "${var.amiid}"
    availability_zone = "us-east-2a"
    instance_type = "t2.medium"
    key_name = "${var.ssh_key}"
    vpc_security_group_ids = ["${aws_security_group.demo2_dbsg.id}"]
    subnet_id = "${var.private_subnet_id}"
    source_dest_check = false

    tags {
        Name = "Data server instance demo2"
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
