terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}
variable "image_id" {
  type = string
}
provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "example" {
  ami           = var.image_id
  instance_type = "t2.micro"

  tags = {
    Name = "example"
  }
}
