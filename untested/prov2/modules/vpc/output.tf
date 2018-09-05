ouput "vpcid" {
   value = "${aws_vpc.demo2_vpc.id}"
}

ouput "publicid" {
   value = "${aws_subnet.demo2_public.id}"
}

ouput "privateid" {
   value = "${aws_subnet.demo2_private.id}"
}
