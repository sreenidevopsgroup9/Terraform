provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region

}



resource "aws_vpc" "kia_vpc" {
  cidr_block = var.vpc_cidr_block
  instance_tenancy = "default"
  tags =  {
    Name = "kia_vpc"

}

}



resource "aws_subnet" "kia_subnet" {
  vpc_id = aws_vpc.kia_vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.availability_zone
  tags =  {
   Name = "kia_subnet"
}
}


resource "aws_internet_gateway" "kia-igw" {

  vpc_id = aws_vpc.kia_vpc.id
  tags = {
    Name = "kia-igw"
  }

}




resource "aws_route_table" "kia_rtb" {
  vpc_id = aws_vpc.kia_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kia-igw.id
}
  tags = {
    Name = "kia-rtb"

}
}



resource "aws_route_table_association" "kia_association" {

  subnet_id = aws_subnet.kia_subnet.id
  route_table_id = aws_route_table.kia_rtb.id
}





resource "aws_instance" "kia_instance" {
  ami = var.ami
  subnet_id = aws_subnet.kia_subnet.id
  count = var.number_of_instance
  associate_public_ip_address = var.associate_public_ip_address_boolean
  instance_type = var.instance_type_map["large"]
  key_name = var.key_name
  availability_zone = var.availability_zone
  tags = {
    Name = "kia-instance"
}

}


variable "instance_type_string" {
  type = string
  default = "t2.micro"
  description = "Intance type is choosed from this variable block"
}


variable "instance_type_list" {
  type = list
  default = ["t2.nano", "t2.micro", "t2.medium", "t2.large"]
}



variable "instance_type_map" {
  type = map
  default = ({
    small = "t2.micro"
    medium = "t2.medium"
    large = "t2.large"

})

}


variable "associate_public_ip_address_boolean" {
  type = bool
  default = "true"
}


variable "access_key" {
  type = string

}


variable "secret_key" {
  type = string
}

variable "region" {
  type = string
}





variable "vpc_cidr_block" {
  type = string 
  default = "30.30.0.0/16"
}


variable "subnet_cidr_block" {
  type = string
  default = "30.30.0.0/24"

}



variable "availability_zone" {
  type = string
  default = "ap-southeast-1a"
}



variable "ami" {
  type = string
  default = "ami-00e912d13fbb4f225"
}


variable "number_of_instance" {
  type = string
  default = "1"
}

variable "key_name" {
  type = string
  default = "sreenidevops"
}




output "vpc_id" {
  value = aws_vpc.kia_vpc.id
}




output "subnet_id" {
  value = aws_subnet.kia_subnet.id
}





data "aws_instance" "sreenidevops_machine" {
   instance_id = "i-04f64f429e82e4c6e"

}


output "public_ip_sreenidevops" {
  value = data.aws_instance.sreenidevops_machine.public_ip
}
