resource "aws_launch_template" "template" {
  name                            = "template-for-roboshop"
  image_id                        = "ami-059e6ca6474628ef0"
  instance_market_options {
    market_type                   = "spot"
  }
  instance_type                   = "t3.micro"
  vpc_security_group_ids          = ["sg-02aea963894a03e73"]
}

output "template_id" {
  value = aws_launch_template.template.id
}