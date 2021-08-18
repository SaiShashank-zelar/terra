provider "aws" {
  access_key = "AKIA3O3BDMKKKXCPEF36"
  secret_key = "cWFePiVXSTt4mim9EghxrLu2Y9ZtxaVaU3fkUreY"
  region     = "us-east-1"
}
resource "aws_instance" "example" {
  ami           = "ami-0eb5f3f64b10d3e0e"
  instance_type = "t2.micro"
  security_groups = ["${aws_security_group.ubuntu_allow_http_ssh.name}"]
  tags = {
    Name = "terra"
  }
}
resource "aws_security_group" "ubuntu_allow_http_ssh" {
  name = "launch-wizard-3"
  description = "launch-wizard-3 created 2021-04-12T12:13:23.019+05:30"
  #ingress {
  #  from_port = 80
  #  protocol = "tcp"
  #  to_port = 80
  #  cidr_blocks = ["0.0.0.0/0"]
  #}
  #ingress {
  #  from_port = 22
  #  protocol = "tcp"
  #  to_port = 22
  #  cidr_blocks = ["0.0.0.0/0"]
  #}
  #egress {
  #  from_port = 0
  #  protocol = "-1"
  #  to_port = 0
  #  cidr_blocks = ["0.0.0.0/0"]
  #}
}
output "ip" {
  value = "${aws_instance.example.public_ip}"
}