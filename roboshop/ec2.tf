module "template" {
  source = "./launch-template"
}

module "ec2" {
  source            = "./ec2"

}

