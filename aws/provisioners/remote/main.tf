provider "aws" {
  access_key = "AKIA4EUA345PA2YUHVV6"
  secret_key = "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"
  region     = "us-east-1"
}



resource "aws_instance" "provisioner-instance" {
  ami           = "ami-0778521d914d23bc1"
  instance_type = "t2.micro"
  key_name = "this-key-is-for-launch-template"
  tags = {
    Name = "remote-machine"
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("/home/ubuntu/this-key-is-for-launch-template.pem")
    host        = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "curl ifconfig.me",
      "whoami",
    ]
  }
}
