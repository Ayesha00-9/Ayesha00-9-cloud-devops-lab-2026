resource "aws_iam_role" "ec2" {
  name = "${var.project_name}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "${var.project_name}-ec2-role"
  }
}

resource "aws_iam_instance_profile" "ec2" {
  name = "${var.project_name}-ec2-profile"
  role = aws_iam_role.ec2.name
}

# S3 access for EC2
resource "aws_iam_role_policy_attachment" "s3_read_only" {
  role       = aws_iam_role.ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

# CloudWatch access for EC2
resource "aws_iam_role_policy_attachment" "cloudwatch" {
  role       = aws_iam_role.ec2.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# Jenkins username in SSM Parameter Store
resource "aws_ssm_parameter" "jenkins_username" {
  name  = "/${var.project_name}/jenkins/username"
  type  = "SecureString"
  value = var.jenkins_username

  tags = {
    Name = "${var.project_name}-jenkins-username"
  }
}

# Jenkins password in SSM Parameter Store
resource "aws_ssm_parameter" "jenkins_password" {
  name  = "/${var.project_name}/jenkins/password"
  type  = "SecureString"
  value = var.jenkins_password

  tags = {
    Name = "${var.project_name}-jenkins-password"
  }
}