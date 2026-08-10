resource "aws_instance" "bastion" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = "cloud-devops-key"
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.bastion_security_group_id]
  associate_public_ip_address = true
  iam_instance_profile        = var.ec2_instance_profile_name

  tags = {
    Name = "${var.project_name}-bastion"
  }
}

resource "aws_instance" "app" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = "cloud-devops-key"
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.app_security_group_id]
  iam_instance_profile   = var.ec2_instance_profile_name

  tags = {
    Name = "${var.project_name}-app"
  }
}