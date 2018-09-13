output "ror_ip" {
   value = "${aws_instance.demo2_rorapp.public_ip}"
}

output "ror_privip" {
   value = "${aws_instance.demo2_rorapp.private_ip}"
}

output "db_ip" {
  value = "${aws_instance.demo2_db_instance.private_ip}"
}
