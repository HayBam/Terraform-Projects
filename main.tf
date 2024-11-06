provider "aws" {
	region = "us-east-1"
}
resource "aws_instance" "example" {
	ami = "ami-06b21ccaeff8cd686"
	instance_type = "t2.micro"

	user_data = <<-EOF
			#!/bin/bash
			echo "Hello Welcome to Terraform World" > index.html
			nohup busybox httpd -f -p 8080 &
			EOF
	
	tags = {
		Name = "TerraformExample"
	}
}

resource "aws_security_group" "instance" {
	name = "terraform-example-instance"

	ingress {
		from_port = 8080
		to_port = 8080
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
		}
}
