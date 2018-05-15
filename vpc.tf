#####Create VPC########

resource "aws_vpc" "vpc" {
  cidr_block       = "${var.cidr_addr}"
  enable_dns_support = true
  enable_dns_hostnames = true
  
  tags {
    Name = "vpc"
    Environment = "dev"
  }
}

###Create Private Subnet##########

resource "aws_subnet" "private" {
  vpc_id     = "${aws_vpc.vpc.id}"
  cidr_block = "${var.private_subnet}"
  availability_zone = "us-west-2a" 
  tags {
    Name = "private_subnet"
    Environment = "dev"
    APP = "Database Subnet"
  }
}

###Create Public Subnet##########

resource "aws_subnet" "public" {
  vpc_id     = "${aws_vpc.vpc.id}"
  cidr_block = "${var.public_subnet}"
  availability_zone = "us-west-2a" 
  tags {
    Name = "public_subnet"
    Environment = "dev"
    APP = "Frontend Subnet"
  }
}

###Create Internet Gateway##########

resource "aws_internet_gateway" "internet_gateway" {

  vpc_id = "${aws_vpc.vpc.id}"
  tags  {
    Name = "internet_gateway"
	  Environment = "dev"  
  
    }
}
  

###Create AWS Route Table##########

resource "aws_route_table" "public" {

  vpc_id = "${aws_vpc.vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.internet_gateway.id}"
  }      
  
  tags  {
    Name = "RT_Public"
	  Environment = "dev"  
  
    }
}


###Assign the route table to the public Subnet###
resource "aws_route_table_association" "public" {
  subnet_id = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.public.id}"
}




###Create Sec group for Database & Private Subnet######

resource "aws_security_group" "db" {
  name = "db_secrule"
  description = "Allow Database SSH Port communication"


 ingress {
   from_port   = 22
   to_port     = 22
   protocol    = "tcp"
   cidr_blocks = ["${var.private_subnet}"]  
   description = "Inbound SSH traffic"
 }


   ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["${var.private_subnet}"]
    description = "Inbound Ping traffic"
  }


  ingress {
   from_port   = 1521
   to_port     = 1521
   protocol    = "tcp"
   cidr_blocks = ["${var.private_subnet}"]
   description = "DB Port"
 }
 
vpc_id = "${aws_vpc.vpc.id}"


tags  {
    Name = "DB Secrules"
	  Environment = "Dev"  
  
    }
}




###Create Sec group for Webapp & Public Subnet######

resource "aws_security_group" "web" {
  name = "web_secrule"
  description = "Allow incoming HTTP connections & SSH access"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "DB Secrules"
    Env  = "Dev"
  }
}


