provider "aws" {
  access_key = "AKIA4EUA345PELF4OHHK"
  secret_key = "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"
  region     = "us-east-1"

}



resource "aws_instance" "resource-one" {
  ami           = "ami-0778521d914d23bc1"
  instance_type = "t2.micro"
  tags = {
    Name = var.name
}

}


variable "name" {
  type = string
}

