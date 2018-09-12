output "vpcid" {
   value = "${aws_vpc.demo2_vpc.id}"
}

output "publicid" {
   value = "${aws_subnet.demo2_public.id}"
}

output "privateid" {
   value = "${aws_subnet.demo2_private.id}"
}

output "natip" {
   value = "${aws_eip.demo2_nat_eip.public_ip}"
}
