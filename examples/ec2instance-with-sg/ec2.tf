resource "aws_instance" "sample" {
  ami                   = "ami-059e6ca6474628ef0"
  instance_type         = "t2.micro"

}

provider "aws" {
  region = "us-east-1"
}

output "public_ip" {
  value = aws_instance.sample.public_ip
}