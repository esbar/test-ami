source "amazon-ebs" "concourse" {
  ami_name      = "concourse-{{timestamp}}"
  profile       = "default"
  instance_type = "t2.micro"
  region        = "us-west-2"
  source_ami_filter {
    filters = {
      name                = "*amzn2-ami-hvm-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
  ssh_username = "ec2-user"
  tags = {
    "Name"        = "concourse"
    "Environment" = "Production"
    "OS_Version"  = "amazon"
    "Release"     = "Latest"
    "Created-by"  = "Packer"
  }
}

build {
  sources = [
    "source.amazon-ebs.concourse"
  ]





  provisioner "shell" {

    inline = [
      "sudo yum update -y",
      "sudo yum install -y git",
      "wget https://github.com/concourse/concourse/releases/download/v7.6.0/concourse-7.6.0-linux-amd64.tgz",
      "tar -xvzf concourse-7.6.0-linux-amd64.tgz",
      "sudo mv concourse /usr/local/concourse",
      "sudo useradd --system --home-dir /usr/local/concourse --shell /usr/sbin/nologin concourse",
      "sudo chown -R concourse:concourse /usr/local/concourse",
      "sudo ln -s /usr/local/concourse/concourse /usr/local/bin/concourse",
      "sudo mkdir -p /etc/concourse",
      "sudo chown -R concourse:concourse /etc/concourse",
      "sudo bash -c 'echo \"concourse:changeme\" | chpasswd'"
    ]
  }

  provisioner "file" {
    source      = "assets/concourse.service"
    destination = "/tmp/concourse.service"
  }

  provisioner "shell"{
    inline = ["sudo mv /tmp/concourse.service /etc/systemd/system/concourse.service"]
  }
  provisioner "breakpoint" {
    disable = false
    note    = "final validate"
  }
  post-processor "manifest" {}
}
