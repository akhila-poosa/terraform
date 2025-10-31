data "aws_ami" "devops" {
    owners           = ["973714476881"]
    most_recent      = true
    
    filter {
        name   = "name"
        values = ["RHEL-9-DevOps-Practice"]
    }

    filter {
        name   = "root-device-type"
        values = ["ebs"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
}

output "ami_id" {
    value = data.aws_ami.devops.id
}

data "aws_instance" "mongodb" {
    instance_id = "i-0715e6a401456f629" #its not permanent
}

output "mongodb_info" {
    value = data.aws_instance.mongodb.public_ip
}