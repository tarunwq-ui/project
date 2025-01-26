provider "aws" {
  region = "ap-south-1"
}

module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name                   = "E-Commerce_Website"
  instance_type          = "t2.large"
  ami                    = "ami-00bb6a80f01f03502"
  key_name               = "ANSIBLE"
  monitoring             = true
  # Uncomment and provide a valid security group module if required
  # vpc_security_group_ids = [module.sg.security_group_id]
  subnet_id              = "subnet-0445e169b5580cbee"
  user_data              = file("userdata.sh")

  root_block_device = [
    {
      volume_size = 20
      volume_type = "gp3"
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name        = "amazon-server"
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = "vpc-05ffbe84918dd288e"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    description = "Jenkins port"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    description = "HTTPS"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "SSH"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    description = "SonarQube port"
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    description = "All traffic"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
