
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.aws_region}"
}


########EC2 DB Instance Creation##############

resource "aws_instance" "db" {
   ami  = "${var.ami}"
   instance_type = "t2.micro"
   subnet_id = "${aws_subnet.private.id}"
   vpc_security_group_ids = ["${aws_security_group.db.id}"]
   associate_public_ip_address = true
   source_dest_check = false
   

  tags {
    Name = "db"
  }
}


########EC2 WEB Instance Creation##############

resource "aws_instance" "web" {
   ami  = "${var.ami}"
   instance_type = "t2.micro"
   subnet_id = "${aws_subnet.public.id}"
   vpc_security_group_ids = ["${aws_security_group.web.id}"]
   associate_public_ip_address = true
   source_dest_check = false
   

  tags {
    Name = "webserver"
  }
}



