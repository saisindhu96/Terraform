resource "aws_instance" "sample" {
  ami                    = "ami-059e6ca6474628ef0"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

}

terraform {
  backend "s3" {
    bucket                    = "terraform-batch"
    key                       = "sample/terraform.tfstate"
    region                    = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}


