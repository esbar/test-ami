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

resource "aws_ami" "example" {
  name                = "example"
  description         = "example ami"
  virtualization_type = "hvm"
  source_instance_id  = aws_instance.example.id
  tags = {
    Name = "example"
  }
}
