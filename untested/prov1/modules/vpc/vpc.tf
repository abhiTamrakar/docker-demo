resource "aws_vpc" "demo2_vpc" {
    cidr_block = "${var.vpccidr}"
    enable_dns_hostnames = true
    tags {
        Name = "demo2_vpc"
    }
}
