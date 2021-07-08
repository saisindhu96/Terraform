resource "aws_spot_instance_request" "cheap_worker" {
  count                  = length(var.COMPONENTS)
  ami                    = "ami-059e6ca6474628ef0"
  spot_price             = "0.0031"
  instance_type          = "t3.micro"
  vpc_security_group_ids = ["sg-02aea963894a03e73"]

  tags                   = {
    Name                 = element(var.COMPONENTS, count.index)
  }
}

variable "COMPONENTS" {}


resource "null_resource" "wait" {
  depends_on = [aws_spot_instance_request.cheap_worker]
  triggers = {
    abc = timestamp()
  }

  provisioner "local-exec" {
    command = "sleep 60"
  }
}

resource "aws_ec2_tag" "spot" {
  depends_on          = [null_resource.wait]
  count                  = length(var.COMPONENTS)
  resource_id            = element(aws_spot_instance_request.cheap_worker.*.spot_instance_id, count.index)
  key                    = "Name"
  value                  = element(var.COMPONENTS, count.index)
}

resource "aws_route53_record" "dns" {
  depends_on             = [null_resource.wait]
  count                  = length(var.COMPONENTS)
  zone_id                = "Z0724247R4KE3AIA5B4P"
  name                   = "${element(var.COMPONENTS, count.index)}.roboshop.internal"
  type                   = "A"
  ttl                    = "300"
  records                = [element(aws_spot_instance_request.cheap_worker.*.private_ip, count.index)]
}