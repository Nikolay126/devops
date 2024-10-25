output "ubuntu_ami" {
  value = data.aws_ami.ubuntu-ami.id
}

output "amazon_linux_ami" {
  value = data.aws_ami.amazon-linux-ami.id
}