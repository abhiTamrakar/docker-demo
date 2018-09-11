resource "aws_internet_gateway" "demo2_igw" {
    vpc_id = "${aws_vpc.demo2_vpc.id}"
}

/*
  Public Subnet
*/
resource "aws_subnet" "demo2_public" {
    vpc_id = "${aws_vpc.demo2_vpc.id}"

    cidr_block = "${var.public_cidr}"
    availability_zone = "us-east-2a"
    map_public_ip_on_launch = true

    tags {
        Name = "Public Subnet demo2"
    }
}

resource "aws_route_table" "demo2_public_route" {
    vpc_id = "${aws_vpc.demo2_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.demo2_igw.id}"
    }

    tags {
        Name = "Public Subnet demo2"
    }
}

resource "aws_route_table_association" "demo2_public_assoc" {
    subnet_id = "${aws_subnet.demo2_public.id}"
    route_table_id = "${aws_route_table.demo2_public_route.id}"
}

/*
  Private Subnet
*/
resource "aws_subnet" "demo2_private" {
    vpc_id = "${aws_vpc.demo2_vpc.id}"

    cidr_block = "${var.private_cidr}"
    availability_zone = "us-east-2a"

    tags {
        Name = "Private Subnet demo2"
    }
}

resource "aws_route_table" "demo2_private_route" {
    vpc_id = "${aws_vpc.demo2_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        instance_id = "${aws_instance.demo2_nat_instance.id}"
    }

    tags {
        Name = "Private Subnet demo2"
    }
}

resource "aws_route_table_association" "demo2_private_assoc" {
    subnet_id = "${aws_subnet.demo2_private.id}"
    route_table_id = "${aws_route_table.demo2_private_route.id}"
}

