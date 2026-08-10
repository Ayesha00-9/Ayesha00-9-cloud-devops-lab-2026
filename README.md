# Cloud DevOps Lab 2026

This repository contains my Cloud DevOps lab work using AWS, Terraform, Ansible, Docker and GitHub.

## Project Work

### 1. Git & GitHub

- Created a public GitHub repository
- Set up branches and pull request workflow
- Added branch protection and PR rules
- Created a GitHub Projects Kanban board
- Added issue templates for:
  - Bug
  - Feature
  - Task

## 2. AWS Infrastructure with Terraform

Terraform is used to create and manage the AWS infrastructure.

The setup includes:

- VPC with a CIDR block
- Public subnet for the Bastion host
- Private subnet for the application server
- Internet Gateway
- NAT Gateway
- Bastion EC2 instance
- Application EC2 instance

### Terraform State

Terraform state is stored remotely in AWS S3.

- S3 bucket: `cloud-devops-tf-state-ayesha`
- DynamoDB table: `cloud-devops-tf-lock`
- AWS region: `ap-south-1`
- S3 versioning is enabled
- DynamoDB is used for Terraform state locking

Terraform state files and local Terraform files are excluded through `.gitignore`.

## 3. Security & Server Configuration

Ansible is used to configure the EC2 instances after they are provisioned by Terraform.

### Installed software

- Docker
- Docker Compose
- Python
- UFW
- Fail2Ban

The installation was checked using:

```bash
docker --version
docker compose version
python3 --version
```

### Firewall

UFW is enabled on both servers.

The current rules include:

- SSH (22)
- HTTP (80)
- HTTPS (443)

Fail2Ban is also enabled.

```bash
sudo ufw status
sudo systemctl is-active fail2ban
```

### User and SSH Configuration

A separate `devops` user is configured for server administration.

Root SSH login is disabled.

The private application server is accessed through the Bastion host instead of being directly exposed to the internet.

## IAM

An IAM role is configured for EC2 to provide access to the required AWS services.

The role is intended for:

- S3
- CloudWatch

AWS credentials are not hardcoded in the project.

## Ansible Vault

Ansible Vault is used for sensitive Ansible variables.

Vault passwords and decrypted secret files are excluded from Git.

## Jenkins Credentials

Jenkins credentials are stored in AWS Systems Manager (SSM) Parameter Store instead of being hardcoded in the repository.

## Repository Structure

```text
cloud-devops-lab-2026/
├── ansible/
├── terraform/
├── .github/
├── .gitignore
└── README.md
```

## Verification

Some of the configured services were verified from the servers.

### Docker

```bash
ansible -i ansible/inventory.ini all -m shell -a 'docker --version'
```

### Docker Compose

```bash
ansible -i ansible/inventory.ini all -m shell -a 'docker compose version'
```

### Python

```bash
ansible -i ansible/inventory.ini all -m shell -a 'python3 --version'
```

### UFW

```bash
ansible -i ansible/inventory.ini all -m shell -a 'sudo ufw status'
```

### Fail2Ban

```bash
ansible -i ansible/inventory.ini all -m shell -a 'sudo systemctl is-active fail2ban'
```

### Nginx

Nginx was also checked on the application server:

```bash
ansible -i ansible/inventory.ini app_servers -m shell -a 'systemctl is-active nginx'
```

## Technologies

- AWS
- Terraform
- Ansible
- Docker
- Docker Compose
- Git
- GitHub
- Python
- Jenkins
- UFW
- Fail2Ban
- S3
- DynamoDB
- IAM
- SSM Parameter Store
