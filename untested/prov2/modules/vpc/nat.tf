/*
  NAT Instance
*/
resource "aws_security_group" "demo2_nat" {
    name = "vpc_nat"
    description = "Allow traffic to pass from the private subnet to the internet"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["${var.private_cidr}"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["${var.private_cidr}"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.organization_ip}"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["${var.organization_ip}"]
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
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.vpccidr}"]
    }
    egress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.demo2_vpc.id}"

    tags {
        Name = "NATSG demo2"
    }
}

resource "aws_instance" "demo2_nat_instance" {
    ami = "ami-0e3ec4087462e2b6b" # this is a special ami preconfigured to do NAT
    availability_zone = "us-east-2a"
    instance_type = "t2.micro"
    key_name = "${var.ssh_key}"
    vpc_security_group_ids = ["${aws_security_group.demo2_nat.id}"]
    subnet_id = "${aws_subnet.demo2_public.id}"
    associate_public_ip_address = true
    source_dest_check = false

    tags {
        Name = "VPC NAT demo2"
    }
}

resource "aws_eip" "demo2_nat_eip" {
    instance = "${aws_instance.demo2_nat_instance.id}"
    vpc = true
}
