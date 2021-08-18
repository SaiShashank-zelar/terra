provider "aws" {
  access_key = "AKIA3O3BDMKKKXCPEF36"
  secret_key = "cWFePiVXSTt4mim9EghxrLu2Y9ZtxaVaU3fkUreY"
  region     = "us-east-1"
}
resource "aws_instance" "example" {
  count         = var.instance_count
  ami           = "ami-0eb5f3f64b10d3e0e"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.ubuntu_allow_http_ssh.name}"]
  tags = {
    Name = "terra-${count.index + 1}"
  }
}
resource "aws_security_group" "ubuntu_allow_http_ssh" {
  name = "ubuntu_allow_http_ssh"
  description = "Allow HTTP and SSH inbound traffic"
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
variable "instance_count" {
  default ="2"
}
output "ip" {
  value = "${aws_instance.example.public_ip}"
}