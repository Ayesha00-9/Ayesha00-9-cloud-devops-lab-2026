# Cloud DevOps Lab 2026

A hands-on Cloud DevOps project demonstrating Git/GitHub, Infrastructure as Code using Terraform, AWS infrastructure, security, and server automation using Ansible.

## 1. Git & Project Setup

- Public GitHub repository
- Git branches and protected branches
- Pull Request workflow
- Branch protection rules
- GitHub Projects / Kanban board
- Issue templates: Bug, Feature, Task

### Branch Workflow

```text
Feature Branch
      |
      v
Pull Request
      |
      v
Main Branch
```

---

## 2. Infrastructure as Code – Terraform

Terraform is used to provision and manage AWS infrastructure.

### AWS Architecture

```text
                         Internet
                            |
                            v
                    Internet Gateway
                            |
                            v
                    +---------------+
                    |      VPC      |
                    |   10.0.0.0/16 |
                    +-------+-------+
                            |
                +-----------+-----------+
                |                       |
                v                       v
          Public Subnet            Private Subnet
                |                       |
                v                       v
          Bastion EC2               App EC2
                                        |
                                        v
                                   NAT Gateway
                                        |
                                        v
                                     Internet
```

### Infrastructure Components

- VPC with CIDR block
- Public subnet for Bastion Host
- Private subnet for Application Server
- Internet Gateway
- NAT Gateway
- Bastion EC2 instance
- Application EC2 instance

### Terraform State

Terraform state is stored remotely in an AWS S3 bucket.

DynamoDB is used for Terraform state locking, and S3 versioning is enabled to retain previous state versions.

```text
Terraform
   |
   +----> S3
   |       └── Terraform State
   |
   └----> DynamoDB
           └── State Lock
```

---

## 3. Security & Automation

Ansible is used to configure and secure the EC2 instances after Terraform provisions them.

```text
Terraform
    |
    v
AWS Infrastructure
    |
    v
EC2 Instances
    |
    v
Ansible
    |
    +-- Docker
    +-- Docker Compose
    +-- Python
    +-- UFW
    +-- Fail2Ban
    +-- User Configuration
```

### Security Groups

AWS Security Groups are used as network-level firewalls.

| Port | Protocol | Purpose |
|------|----------|---------|
| 22 | TCP | SSH |
| 80 | TCP | HTTP |
| 443 | TCP | HTTPS |

Rules should be restricted to trusted sources wherever possible.

### IAM Role

An IAM role is used for EC2 access to required AWS services without storing AWS access keys directly on the server.

Required access includes:

- Amazon S3
- Amazon CloudWatch

### Ansible Configuration

Ansible is used to install and configure:

- Docker
- Docker Compose
- Python
- UFW
- Fail2Ban
- User access

Verification commands:

```bash
docker --version
docker compose version
python3 --version
sudo ufw status
sudo systemctl is-active fail2ban
```

### User Access

A dedicated `devops` user is configured for administration, and root SSH login is disabled.

The secure access flow is:

```text
Developer
    |
    v
Bastion Host
    |
    v
Private Application Server
```

### Ansible Vault

Ansible Vault is used to encrypt sensitive information.

Vault passwords and decrypted secret files must not be committed to GitHub.

### Jenkins Credentials

Jenkins credentials are stored in AWS Systems Manager (SSM) Parameter Store instead of being hardcoded in source code.

```text
SSM Parameter Store
        |
        v
     Secret
        |
        v
      Jenkins
```

---

## Technologies Used

- Git
- GitHub
- GitHub Projects
- Terraform
- AWS VPC
- AWS EC2
- AWS S3
- AWS DynamoDB
- AWS IAM
- AWS SSM Parameter Store
- Ansible
- Ansible Vault
- Docker
- Docker Compose
- Python
- UFW
- Fail2Ban
- Jenkins

---

## Project Structure

```text
cloud-devops-lab-2026/
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── backend.tf
│   └── ...
│
├── ansible/
│   ├── inventory.ini
│   ├── playbook.yml
│   ├── roles/
│   └── ...
│
├── .github/
│   └── ISSUE_TEMPLATE/
│       ├── bug_report.md
│       ├── feature_request.md
│       └── task.md
│
├── .gitignore
└── README.md
```

---

## Security Practices

- Protected Git branches
- Pull Request based workflow
- Private application subnet
- Bastion Host for secure access
- AWS Security Groups
- UFW firewall
- Fail2Ban
- IAM roles instead of hardcoded AWS credentials
- Ansible Vault for secrets
- SSM Parameter Store for Jenkins credentials
- Terraform remote state
- Terraform state locking
- S3 state versioning

---

## Verification

Terraform backend resources were verified using:

```bash
aws s3api head-bucket   --bucket cloud-devops-tf-state-ayesha
```

```bash
aws dynamodb describe-table   --table-name cloud-devops-tf-lock   --query 'Table.TableStatus'
```

S3 versioning was enabled and verified.

---

## Project Goal

The goal of this project is to demonstrate how cloud infrastructure can be:

- Provisioned automatically
- Configured automatically
- Secured using multiple layers
- Managed through Git
- Protected using Pull Requests
- Reproducibly deployed using Infrastructure as Code
- Configured using automation
- Managed using secure secret-storage practices

---

## Author

**Ayesha**

Cloud DevOps Lab 2026