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
        from_port = 9100
        to_port = 9100
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

    user_data_base64 = <<HEREDOC
IyEvYmluL2Jhc2ggLXhldgoKIyBEbyBzb21lIGNoZWYgcHJlLXdvcmsKL2Jpbi9ta2RpciAtcCAv
ZXRjL2NoZWYKL2Jpbi9ta2RpciAtcCAvdmFyL2xpYi9jaGVmCi9iaW4vbWtkaXIgLXAgL3Zhci9s
b2cvY2hlZgoKY2QgL2V0Yy9jaGVmLwoKIyBJbnN0YWxsIGNoZWYKY3VybCAtTCBodHRwczovL29t
bml0cnVjay5jaGVmLmlvL2luc3RhbGwuc2ggfCBiYXNoIHx8IGVycm9yICdjb3VsZCBub3QgaW5z
dGFsbCBjaGVmJwoKIyBDcmVhdGUgZmlyc3QtYm9vdC5qc29uCmNhdCA+ICIvZXRjL2NoZWYvZmly
c3QtYm9vdC5qc29uIiA8PCBFT0YKewogICAicnVuX2xpc3QiIDpbCiAgICJyb2xlW2Jhc2VdIgog
ICBdCn0KRU9GCgooCmNhdCA8PCAnX0VPRl8nCi0tLS0tQkVHSU4gUlNBIFBSSVZBVEUgS0VZLS0t
LS0KTUlJRW93SUJBQUtDQVFFQWtqQVVMZzJ3V1Rpb1dpYmFNYzliZ1NOTDdNTWQyd3N1YVdBT1Jy
TkNEdUg3aWpiWApqVkFXWGJHZ3QzZm9YaEVZbno0SFJJblNpNldsQ2tNVjhuWmZRdStNcTU5dXVU
WUQxZ2NzSlliTGxBUXEwbmkxClNtSnV2N1BlZEYvZVpEc0Q0cC93Mm1WU2JET1dIaFd1bnJmNFpl
cWIwQVh5OHFKNHdMaEV0OVhiV0Z4STUwa1QKUWh6ZHlLTUpEVDRlcWE0dTU4SU1KeWNGb3hOYklz
S2IxMjBKbHZCcW01cTdvTHhkTzVWRzFLL1J2U2VvUmlzSQpzbW1ubWlVWCtBc2tjOVZGVFgySFNE
T2FBZmVDUkNTWkRYUkRjaFpzRkhqbEY1MGZuNkI3bFBiRGN5QW00djA2CmNDYzZmS293WlpXQTE5
UURtWktWWFgrVERMOGxaZzhoeWdDT3dRSURBUUFCQW9JQkFCVExOZk9mQ3RpR0VKeFMKTG5NclZZ
NjI0SlBhNVNKRkl1TG1RT0dabWVuWUJ4bVAxM1ZJVVFZZXdBZVl6THFrbitYMndyM2pCTW5NVS85
egpyMmwvb09rNmZiM2p2YkltbHNFWTRCU3VhY0t5SFEwM0VrSjBZZUJ1eTFPdVYwbldneVQzTHlG
QmpFbkx4S3llCjFPbktyVkNCNEl2a2JMeEtrL2FGdjNDT3dOWitndTgyR2xmdlhpTkRXWmVwa0hy
ZTVxcSs0WUFSelhVK0E4NGUKdHVqZ2VKSk1BQXMvcUlaL0xZUjltMFQ1MDUrdFQ0dWx5MFhBcmly
SkN4eCtBR3p5bHUzMWhMUDhmdjVjLzA3WQozT2FVU1lNZmp1cnIrZ0JZOEtVbXJKd2VEa2N2M1Bq
TTVpYnVIUzZxc09OYW1NYjVYWjhMY3ZnK0tYc0tZUzZRClRwaHpPK0VDZ1lFQXdtVUtVOHdFVW5P
NFVzbUVpb3g1bUhnTnE0ZFhLZ2Vxbys5M29neWx1Z0dLQkVoSExidWoKQ2FLY2NEVk9YOHR2OERP
cXAvcUlCUERUL01QRWlsZWFUdVg5dDFxRlJXU2Z0N3VlYTlwaXZ4eHpRT1NVZUxSYwpQSVFWdnRD
SjdjZE00V2tXbDd0ZFlMOFMyek4zZDNFRFFpNk1RTEs5WEFWWW14ZndSa0tSWlUwQ2dZRUF3SVFW
Cmd5ZGw0QUhHdHA4SUQ1SW52NGR4c1hJd2Uxb1FiSnd1NGFNSDNJMVBmTE03U0wzV0o0QzRRU2lv
L3BBWG95ekYKOE9maTJJNXRBcXAvQ2RxdHBaaWswQTFJdjl0MlNHeEo0SXFIaTdYanMvMDZXcFZm
Z2VQUUhOeTg5U25SRWZCOApLc0hhWVNsTTNralFwVHQ2QTdNcVRqSEpDSG16YlhHNXArOU14VVVD
Z1lFQWh1OUIydWJMdlR2c0h6TVlXRituCjY4aXhuSFhtY0J0QVBHajF2cnRPc2kxdFV3bWt0cjcv
TGFuOU12b2RlK3NudVREejdZTyt0TWRDTHJycEN5cEIKeHpCb0M4UytxMnRzWGtuU2JvVDVkRFRZ
WDV3SzN6bzZxQnI3U1NkU0JvWUgvSk5JaG13ZEpoR2JraUpJYzlVegpjTllFcnNnakh1UHJIRVRp
bUxLT1lDVUNnWUFWNE96dzh0RkpHK3FSWnBGcjg1aEExQXUvdHRKN3NraWJqMFJrCnNEcDhmakxD
WVR3amtDOStYY3FTM1NRWGloaWxtcmtFSDlaUDloKzlaZEw2TTdmNFVkaXBMRmxRTklqRXdrbkQK
RXZ0RWpXOUxUVVFNZDExYlRhQ2hKeFR5WjhZeTI3bkF3amNuUTZKUXdNVzFnWVRrVnNCQUVyaGVG
amFtQVg2dgo3eW95WVFLQmdEK25CY3RrSzBaU3FHRXZWRWlrVktaNnlBSWw1ZE9SRlBDNHVEOFk3
VnI4dEhIUFA0T2ZlN3dNCnBFaFBRc2hOTGg2K1JTRVIyY09LTnlPZHgrb0JvaW5sclM3cW4zTW1O
ZjluUXdXbkZsTDY5WXNUY0V5VkpQUUUKN0lyTWI0c0t6SDYwOEFycUEydGNBTkowZFE0ZWR3NzB3
L3NWOUhtc2svdXdtZnNhVWxjYQotLS0tLUVORCBSU0EgUFJJVkFURSBLRVktLS0tLQpfRU9GXwop
ID4gL2V0Yy9jaGVmL3Bwb2MtdmFsaWRhdG9yLnBlbQoKIyBDcmVhdGUgY2xpZW50LnJiCi9iaW4v
ZWNobyAnbG9nX2xvY2F0aW9uICAgICAgU1RET1VUJyA+PiAvZXRjL2NoZWYvY2xpZW50LnJiCi9i
aW4vZWNobyAtZSAiY2hlZl9zZXJ2ZXJfdXJsICBcImh0dHBzOi8vYXBpLmNoZWYuaW8vb3JnYW5p
emF0aW9ucy9wcG9jXCIiID4+IC9ldGMvY2hlZi9jbGllbnQucmIKL2Jpbi9lY2hvIC1lICJ2YWxp
ZGF0aW9uX2NsaWVudF9uYW1lIFwicHBvYy12YWxpZGF0b3JcIiIgPj4gL2V0Yy9jaGVmL2NsaWVu
dC5yYgovYmluL2VjaG8gLWUgInZhbGlkYXRpb25fa2V5IFwiL2V0Yy9jaGVmL3Bwb2MtdmFsaWRh
dG9yLnBlbVwiIiA+PiAvZXRjL2NoZWYvY2xpZW50LnJiCi9iaW4vZWNobyAtZSAibm9kZV9uYW1l
ICBcIm5vZGUtZGJcIiIgPj4gL2V0Yy9jaGVmL2NsaWVudC5yYgoKc3VkbyBjaGVmLWNsaWVudCAt
aiAvZXRjL2NoZWYvZmlyc3QtYm9vdC5qc29uCg==
HEREDOC
}
