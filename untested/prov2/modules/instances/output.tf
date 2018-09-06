output "ror_ip" {
   value = "${aws_eip.demo2_roreip.public_ip}"
}
