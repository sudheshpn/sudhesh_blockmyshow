variable "aws_access_key" {}
variable "aws_secret_key" {}


variable "name" {
  description = "Aws Instance Name"
  default = "aws_booking"
}

variable "provider" {
  description = "Aws Instance Provider"
  default = "aws"
}


variable "instance_count" {
  description = "Instance Count"
  default = "2" 
}

variable "ami" {
  description = "The AMI to use"
  default = "ami-a523b4dd"
}

variable "instance_type" {
  description = "Instance Type"
  default = "t2.micro" 
}

variable "key_name" {
  description = "Key Name"
  default = "booking" 
}


variable "monitoring" {
  description = "monitoring"
  default = "true"
}

variable "vpc_security_group_ids" {
  description = "vpc_security_group_ids"
  default = "sg-11a52c6f" 
}

variable "aws_region" {
  description = "Region for the VPC"
  default = "us-west-2"
}

variable "cidr_addr" {
  description = "CIDR Address for ec2 Instance"
  default = "10.0.0.0/16" 
}

variable "private_subnet" {
  description = "private_subnet for webserver"
  default = "10.0.2.0/24" 
}

variable "public_subnet" {
  description = "private_subnet for database"
  default = "10.0.1.0/24" 
}


variable "key_path" {
  description = "SSH Public Key path"
  default = "/home/core/.ssh/id_rsa.pub"
}

