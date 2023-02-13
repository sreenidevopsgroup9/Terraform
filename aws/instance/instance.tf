terraform {
  required_providers {
    aws = {
      version = "~> 4.0"
    }
  }
}



provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA4EUA345PKQHOWFWI"
  secret_key = "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"
}

resource "aws_instance" "first-instance" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = "this-key-is-for-launch-template"
  count         = 3
  tags = {
    Name        = "First-Instance-from-Terraform"
    Environment = "Reserach and Developemnt Area"
    Department  = "DevOps"
  }
}



variable "ami" {
  default = "ami-0778521d914d23bc1"
}


variable "instance_type" {
  default = "t2.micro"

}



