resource "aws_instance" "task2-amazon-linux-ec2" {
  ami           = data.aws_ami.amazon-linux-ami.id
  instance_type = "t2.micro"

  subnet_id = aws_subnet.task2-amazon-linux-subnet.id

  security_groups = [aws_security_group.task2-amazon-linux-sg.id]

  key_name = aws_key_pair.generated_key.key_name

#   user_data = <<-EOF
#               #!/bin/bash
#               echo ${file("nginx.rpm.b64")}" | base64 --decode > /nginx/nginx.rpm
#               yum localinstall -y /nginx/nginx.rpm
#               systemctl start nginx
#               systemctl enable nginx
#               EOF
  tags = {
    Name = "amazon-linux-ec2-task2"
  }
}

resource "aws_instance" "task2-ubuntu-ec2" {
  ami           = data.aws_ami.ubuntu-ami.id
  instance_type = "t2.micro"

  subnet_id = aws_subnet.task2-ubuntu-subnet.id

  security_groups = [aws_security_group.task2-ubuntu-sg.id]

  key_name = aws_key_pair.generated_key.key_name

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install apache2 -y
              echo "${file("index.html")}" > /var/www/html/index.html
              curl -fsSL https://get.docker.com -o get-docker.sh
              sh ./get-docker.sh
              EOF

  provisioner "file" {
    source      = "nginx-1.24.0-1.amzn2023.0.4.x86_64.rpm"
    destination = "/home/ubuntu/nginx.rpm"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("ec2-public-key.pem")
      host        = self.public_ip
    }
  }

  tags = {
    Name = "ubuntu-ec2-task2"
  }
}