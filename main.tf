
terraform {
  backend "remote" {
    #hostname = "app.terraform.io"
    #organization = "bleehashiorg"
    hostname = "blee-ptfe.hashidemos.io"
    organization = "ptfe"
    token = ${TFE_API_TOKEN}
    workspaces {
      #name = "jenkins-test"
      name = "github-jenkins-ec2"
    }
  }
 }


provider aws{
  region = "${var.aws_region}"
  #access_key = "${var.AWS_ACCESS_KEY_ID}"
  #secret_key = "${var.AWS_SECRET_ACCESS_KEY}"
  }

data "aws_ami" "my_image" {
  
  most_recent=true

  filter {
      name   = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
    }

    filter {
      name   = "virtualization-type"
      values = ["hvm"]
    }

    owners = ["099720109477"] # Canonical

}

resource "aws_instance" "blee-ec2" {
  count = "${var.instance_count}"
  ami           = "${data.aws_ami.my_image.id}"
  instance_type = "t2.micro"
  #vpc_security_group_ids = ["${aws_security_group.main_sec_group.id}"]
  #subnet_id = "${aws_subnet.subnet1.id}"
  key_name = "${var.key_name}"
  #tags {
    #Name = "${var.instance_name_vault}"

  #}
}

