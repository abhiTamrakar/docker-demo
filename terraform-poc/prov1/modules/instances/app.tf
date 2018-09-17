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
        cidr_blocks = ["${var.organization_ip}","${var.jenkins_ip}"]
    }
    ingress {
        from_port = 9100
        to_port = 9100
        protocol = "tcp"
        cidr_blocks = ["${var.private_cidr}"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.vpccidr}"]
    }
    ingress {
        from_port = 5601
        to_port = 5601
        protocol = "tcp"
        cidr_blocks = ["${var.vpccidr}"]
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
        from_port = 9100
        to_port = 9100
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
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 123
        to_port = 123
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 123
        to_port = 123
        protocol = "udp"
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
    instance_type = "t2.medium"
    key_name = "${var.ssh_key}"
    vpc_security_group_ids = ["${aws_security_group.demo2_rorsg.id}"]
    subnet_id = "${var.public_subnet_id}"
    associate_public_ip_address = true
    source_dest_check = false

    tags {
        Name = "ROR app demo2"
    }
    user_data_base64 = <<HEREDOC
IyEvYmluL2Jhc2ggLXhldgoKIyBEbyBzb21lIGNoZWYgcHJlLXdvcmsKL2Jpbi9ta2RpciAtcCAv
ZXRjL2NoZWYKL2Jpbi9ta2RpciAtcCAvdmFyL2xpYi9jaGVmCi9iaW4vbWtkaXIgLXAgL3Zhci9s
b2cvY2hlZgoKY2QgL2V0Yy9jaGVmLwoKIyBJbnN0YWxsIGNoZWYKY3VybCAtTCBodHRwczovL29t
bml0cnVjay5jaGVmLmlvL2luc3RhbGwuc2ggfCBiYXNoIHx8IGVycm9yICdjb3VsZCBub3QgaW5z
dGFsbCBjaGVmJwoKKApjYXQgPDwgJ19FT0ZfJwotLS0tLUJFR0lOIFJTQSBQUklWQVRFIEtFWS0t
LS0tCk1JSUVvd0lCQUFLQ0FRRUFrakFVTGcyd1dUaW9XaWJhTWM5YmdTTkw3TU1kMndzdWFXQU9S
ck5DRHVIN2lqYlgKalZBV1hiR2d0M2ZvWGhFWW56NEhSSW5TaTZXbENrTVY4blpmUXUrTXE1OXV1
VFlEMWdjc0pZYkxsQVFxMG5pMQpTbUp1djdQZWRGL2VaRHNENHAvdzJtVlNiRE9XSGhXdW5yZjRa
ZXFiMEFYeThxSjR3TGhFdDlYYldGeEk1MGtUClFoemR5S01KRFQ0ZXFhNHU1OElNSnljRm94TmJJ
c0tiMTIwSmx2QnFtNXE3b0x4ZE81VkcxSy9SdlNlb1Jpc0kKc21tbm1pVVgrQXNrYzlWRlRYMkhT
RE9hQWZlQ1JDU1pEWFJEY2hac0ZIamxGNTBmbjZCN2xQYkRjeUFtNHYwNgpjQ2M2Zktvd1paV0Ex
OVFEbVpLVlhYK1RETDhsWmc4aHlnQ093UUlEQVFBQkFvSUJBQlRMTmZPZkN0aUdFSnhTCkxuTXJW
WTYyNEpQYTVTSkZJdUxtUU9HWm1lbllCeG1QMTNWSVVRWWV3QWVZekxxa24rWDJ3cjNqQk1uTVUv
OXoKcjJsL29PazZmYjNqdmJJbWxzRVk0QlN1YWNLeUhRMDNFa0owWWVCdXkxT3VWMG5XZ3lUM0x5
RkJqRW5MeEt5ZQoxT25LclZDQjRJdmtiTHhLay9hRnYzQ093TlorZ3U4MkdsZnZYaU5EV1plcGtI
cmU1cXErNFlBUnpYVStBODRlCnR1amdlSkpNQUFzL3FJWi9MWVI5bTBUNTA1K3RUNHVseTBYQXJp
ckpDeHgrQUd6eWx1MzFoTFA4ZnY1Yy8wN1kKM09hVVNZTWZqdXJyK2dCWThLVW1ySndlRGtjdjNQ
ak01aWJ1SFM2cXNPTmFtTWI1WFo4TGN2ZytLWHNLWVM2UQpUcGh6TytFQ2dZRUF3bVVLVTh3RVVu
TzRVc21FaW94NW1IZ05xNGRYS2dlcW8rOTNvZ3lsdWdHS0JFaEhMYnVqCkNhS2NjRFZPWDh0djhE
T3FwL3FJQlBEVC9NUEVpbGVhVHVYOXQxcUZSV1NmdDd1ZWE5cGl2eHh6UU9TVWVMUmMKUElRVnZ0
Q0o3Y2RNNFdrV2w3dGRZTDhTMnpOM2QzRURRaTZNUUxLOVhBVllteGZ3UmtLUlpVMENnWUVBd0lR
VgpneWRsNEFIR3RwOElENUludjRkeHNYSXdlMW9RYkp3dTRhTUgzSTFQZkxNN1NMM1dKNEM0UVNp
by9wQVhveXpGCjhPZmkySTV0QXFwL0NkcXRwWmlrMEExSXY5dDJTR3hKNElxSGk3WGpzLzA2V3BW
ZmdlUFFITnk4OVNuUkVmQjgKS3NIYVlTbE0za2pRcFR0NkE3TXFUakhKQ0htemJYRzVwKzlNeFVV
Q2dZRUFodTlCMnViTHZUdnNIek1ZV0Yrbgo2OGl4bkhYbWNCdEFQR2oxdnJ0T3NpMXRVd21rdHI3
L0xhbjlNdm9kZStzbnVURHo3WU8rdE1kQ0xycnBDeXBCCnh6Qm9DOFMrcTJ0c1hrblNib1Q1ZERU
WVg1d0szem82cUJyN1NTZFNCb1lIL0pOSWhtd2RKaEdia2lKSWM5VXoKY05ZRXJzZ2pIdVBySEVU
aW1MS09ZQ1VDZ1lBVjRPenc4dEZKRytxUlpwRnI4NWhBMUF1L3R0Sjdza2liajBSawpzRHA4ZmpM
Q1lUd2prQzkrWGNxUzNTUVhpaGlsbXJrRUg5WlA5aCs5WmRMNk03ZjRVZGlwTEZsUU5JakV3a25E
CkV2dEVqVzlMVFVRTWQxMWJUYUNoSnhUeVo4WXkyN25Bd2pjblE2SlF3TVcxZ1lUa1ZzQkFFcmhl
RmphbUFYNnYKN3lveVlRS0JnRCtuQmN0a0swWlNxR0V2VkVpa1ZLWjZ5QUlsNWRPUkZQQzR1RDhZ
N1ZyOHRISFBQNE9mZTd3TQpwRWhQUXNoTkxoNitSU0VSMmNPS055T2R4K29Cb2lubHJTN3FuM01t
TmY5blF3V25GbEw2OVlzVGNFeVZKUFFFCjdJck1iNHNLekg2MDhBcnFBMnRjQU5KMGRRNGVkdzcw
dy9zVjlIbXNrL3V3bWZzYVVsY2EKLS0tLS1FTkQgUlNBIFBSSVZBVEUgS0VZLS0tLS0KX0VPRl8K
KSA+IC9ldGMvY2hlZi9wcG9jLXZhbGlkYXRvci5wZW0KClBSRUZJWD0kKGNhdCAvZGV2L3VyYW5k
b20gfCB0ciAtZGMgJ2EtekEtWjAtOScgfCBmb2xkIC13IDQgfCBoZWFkIC1uIDEpCgojIENyZWF0
ZSBjbGllbnQucmIKL2Jpbi9lY2hvICdsb2dfbG9jYXRpb24gICAgICBTVERPVVQnID4+IC9ldGMv
Y2hlZi9jbGllbnQucmIKL2Jpbi9lY2hvIC1lICJjaGVmX3NlcnZlcl91cmwgIFwiaHR0cHM6Ly9h
cGkuY2hlZi5pby9vcmdhbml6YXRpb25zL3Bwb2NcIiIgPj4gL2V0Yy9jaGVmL2NsaWVudC5yYgov
YmluL2VjaG8gLWUgInZhbGlkYXRpb25fY2xpZW50X25hbWUgXCJwcG9jLXZhbGlkYXRvclwiIiA+
PiAvZXRjL2NoZWYvY2xpZW50LnJiCi9iaW4vZWNobyAtZSAidmFsaWRhdGlvbl9rZXkgXCIvZXRj
L2NoZWYvcHBvYy12YWxpZGF0b3IucGVtXCIiID4+IC9ldGMvY2hlZi9jbGllbnQucmIKL2Jpbi9l
Y2hvIC1lICJub2RlX25hbWUgIFwibm9kZWFwcC0ke1BSRUZJWH1cIiIgPj4gL2V0Yy9jaGVmL2Ns
aWVudC5yYgo=
HEREDOC
}
