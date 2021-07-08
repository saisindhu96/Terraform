resource "null_resource" "ansible-apply" {
  triggers            = {
  abc                 = timestamp()
}
  count               = length(var.COMPONENTS)
  provisioner "remote-exec" {

    connection {
      host            = "${element(var.COMPONENTS, count.index)}.roboshop.internal"
      user            = "root"
      password        = "DevOps321"
    }

    inline             = [
      "sudo yum install ansible -y",
      "sudo yum remove ansible -y",
      "sudo rm -rf /usr/lib/python2.7/site-packages.ansible*",
      "sudo pip install ansible -y",
      "ansible-pull -i localhost, -U https://github.com/saisindhu96/ansible.git roboshop-pull.yml -e COMPONENT=${element(var.COMPONENTS, count.index)}"
    ]

  }
}

variable "COMPONENTS" {}