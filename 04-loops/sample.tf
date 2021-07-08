resource "aws_instance" "sample" {
  count                   = 2
  ami                     = "ami-059e6ca6474628ef0"
  instance_type           = "t2.micro"

}