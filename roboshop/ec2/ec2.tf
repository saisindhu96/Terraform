resource "aws_spot_instance_request" "cheap_worker" {
  count               = length(var.COMPONENTS)
  ami                 = "ami-059e6ca6474628ef0"
  spot_price          = "0.0031"
  instance_type       = "t3.micro"

  tags                = {
    Name              = element(var.COMPONENTS, count.index)
  }
}

variable "COMPONENTS" {}


resource "time_sleep" "wait" {
  depends_on          = [aws_spot_instance_request.cheap_worker]
  create_duration     = "120s"
  }

resource "aws_ec2_tag" "spot" {
  count               = length(var.COMPONENTS)
  resource_id         = element(aws_spot_instance_request.cheap_worker.*.spot_instance_id, count.index)
  key                 = "Name"
  value               = element(var.COMPONENTS, count.index)
}