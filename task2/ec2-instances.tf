data "aws_ami" "ubuntu-ami" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "name"
    values = ["*ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "amazon-linux-ami" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "name"
    values = ["*al2023-ami-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

output "ubuntu_ami" {
  value = data.aws_ami.ubuntu-ami.id
}

output "amazon_linux_ami" {
  value = data.aws_ami.amazon-linux-ami.id
}

resource "aws_instance" "task2-amazon-linux-ec2" {
  ami           = "ami-06b21ccaeff8cd686"
  instance_type = "t2.micro"

  subnet_id = aws_subnet.task2-subnet.id

  security_groups = [aws_security_group.task2-amazon-linux-sg.id]

  key_name = aws_key_pair.generated_key.key_name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install nginx1.12 -y
              systemctl start nginx sudo systemctl enable nginx
              echo "server { listen 80; server_name mywebsite.com www.mywebsite.com; location / { root /var/www/html; index index.html; } }" > /etc/nginx/conf.d/mywebsite.conf
              echo "<html><body><h1>Hello World</h1></body></html>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "amazon-linux-ec2-task2"
  }
}

resource "aws_instance" "task2-ubuntu-ec2" {
  ami           = "ami-0866a3c8686eaeeba"
  instance_type = "t2.micro"

  subnet_id = aws_subnet.task2-subnet.id

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

  tags = {
    Name = "ubuntu-ec2-task2"
  }
}