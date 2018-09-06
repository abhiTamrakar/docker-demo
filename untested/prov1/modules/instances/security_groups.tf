resource "aws_security_group" "ror_app_sec_grp" {
  name = "ror_app_sec_grp"
  tags {
        Name = "ror_db_sec_grp"
  }
  description = "ONLY HTTP CONNECTION INBOUD"
  vpc_id = "${var.vpcid}"

  ingress {
        from_port = 80
        to_port = 80
        protocol = "TCP"
        cidr_blocks = ["10.0.0.0/16"]
  }
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "TCP"
    cidr_blocks = ["103.6.32.0/24"]
  }
  ingress {
    from_port   = "24224"
    to_port     = "24224"
    protocol    = "TCP"
    cidr_blocks = ["10.0.0.0/16"]
  }
  ingress {
    from_port   = "5601"
    to_port     = "5601"
    protocol    = "TCP"
    cidr_blocks = ["10.0.0.0/16"]
  }
  ingress {
    from_port   = "9101"
    to_port     = "9101"
    protocol    = "TCP"
    cidr_blocks = ["10.0.0.0/16"]
  }
  ingress {
    from_port   = "9100"
    to_port     = "9100"
    protocol    = "TCP"
    cidr_blocks = ["10.0.0.0/16"]
  }
  ingress {
    from_port   = "9200"
    to_port     = "9200"
    protocol    = "TCP"
    cidr_blocks = ["10.0.0.0/16"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ror_db_sec_grp" {
  name = "ror_db_sec_grp"
  tags {
        Name = "ror_db_sec_grp"
  }
  description = "ONLY tcp CONNECTION INBOUND"
  vpc_id = "${var.vpcid}"
  ingress {
      from_port = 3306
      to_port = 3306
      protocol = "TCP"
      security_groups = ["${aws_security_group.ror_app_sec_grp.id}"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ror_alb_sec_grp" {
  name = "ror_alb_sec_grp"
  tags {
        Name = "ror_alb_sec_grp"
  }
  description = "ONLY tcp CONNECTION INBOUND"
  vpc_id = "${var.vpcid}"
  ingress {
      from_port = 80
      to_port = 80
      protocol = "TCP"
      security_groups = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 5601
      to_port = 5601
      protocol = "TCP"
      security_groups = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#output

output "ror_sec_grp_id" {
   value = "${aws_security_group.ror_app_sec_grp.id}"
}

output "ror_db_sec_grp_id" {
   value = "${aws_security_group.ror_db_sec_grp.id}"
}

output "ror_alb_sec_grp_id" {
   value = "${aws_security_group.ror_alb_sec_grp.id}"
}
