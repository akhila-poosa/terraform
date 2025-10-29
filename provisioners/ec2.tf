resource "aws_instance" "terraform" {
  ami                    = "ami-09c813fb71547fc4f"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  tags = {
    Name      = "terraform"
    Terraform = "true"
  }

  # Run a local command after instance creation
  provisioner "local-exec" {
    command    = "echo ${self.private_ip} > inventory"
    on_failure = continue
  }

  # Run local command during destroy
  provisioner "local-exec" {
    command = "echo Instance is destroyed"
    when    = destroy
  }

  # SSH connection details for remote provisioners
  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = self.public_ip
  }

  # Run commands on the instance after creation
  provisioner "remote-exec" {
    inline = [
      "sudo dnf install nginx -y",
      "sudo systemctl start nginx"
    ]
  }

  # Run commands on the instance during destroy
  provisioner "remote-exec" {
    when = destroy
    inline = [
      "sudo systemctl stop nginx",
      "echo 'successfully stopped nginx server'"
    ]
  }
}

# Security Group
resource "aws_security_group" "allow_all" {
  name = "allow-all"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-all"
  }
}