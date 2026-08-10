# Cloud DevOps Lab 2026

This repository contains my cloud and DevOps lab work covering AWS infrastructure, Terraform, Ansible, security, and GitHub project management.

## What this project covers

- GitHub repository and branch workflow
- GitHub Projects board and issue templates
- AWS VPC and subnet setup
- Bastion host and private application server
- Internet Gateway and NAT Gateway
- Terraform remote state with S3
- Terraform state locking with DynamoDB
- AWS Security Groups
- IAM role for EC2
- Server configuration with Ansible
- Docker, Docker Compose and Python setup
- UFW and Fail2Ban
- Linux user and SSH configuration
- Ansible Vault
- Jenkins secrets through AWS SSM Parameter Store

---

## Repository layout

```text
.
├── ansible/
│   ├── inventory.ini
│   └── ...
├── terraform/
│   ├── backend.tf
│   └── ...
├── .github/
│   └── ISSUE_TEMPLATE/
├── .gitignore
└── README.md
```

## AWS setup

The infrastructure is built around one VPC with separate public and private subnets.

```text
                         Internet
                            |
                            |
                    Internet Gateway
                            |
                    +-------+-------+
                    |      VPC      |
                    |   10.0.0.0/16 |
                    +-------+-------+
                            |
              +-------------+-------------+
              |                           |
        Public Subnet               Private Subnet
              |                           |
              |                           |
        Bastion Server              App Server
              |                           |
              |                      NAT Gateway
              |                           |
              +---------------------------+
                          outbound
```

The Bastion server is placed in the public subnet. The application server stays in the private subnet and is reached through the Bastion host.

## Terraform

Terraform is used to create and manage the AWS infrastructure.

The Terraform backend uses:

- **S3** for the Terraform state
- **DynamoDB** for state locking
- **S3 versioning** for previous state versions

Backend resources currently used:

```text
S3 bucket:       cloud-devops-tf-state-ayesha
DynamoDB table:  cloud-devops-tf-lock
Region:          ap-south-1
```

The state is kept outside the Git repository. Terraform working files and state files are excluded through `.gitignore`.

## Ansible

After the EC2 instances are created, Ansible is used for server configuration.

The configuration includes:

```text
Docker
Docker Compose
Python
UFW
Fail2Ban
User access
SSH configuration
```

Basic checks used during setup:

```bash
docker --version
docker compose version
python3 --version
sudo ufw status
sudo systemctl is-active fail2ban
```

## Security

The setup uses multiple layers of security.

### AWS Security Groups

Network access is controlled through Security Groups. The main ports used by the servers are:

| Port | Use |
|------:|-----|
| 22 | SSH |
| 80 | HTTP |
| 443 | HTTPS |

### Bastion access

The private application server is not intended to be accessed directly from the internet.

The access path is:

```text
Local machine
     |
     v
Bastion host
     |
     v
Private application server
```

### UFW and Fail2Ban

UFW provides host-level firewall rules, while Fail2Ban is enabled to help protect services against repeated failed authentication attempts.

## IAM

An IAM role is used with the EC2 instance instead of putting AWS access keys directly on the server.

The role is intended to provide the required access to:

- S3
- CloudWatch

## Secrets

Secrets are kept out of the repository.

### Ansible Vault

Ansible Vault is used for encrypted Ansible secrets.

Vault password files and decrypted secret files are excluded from Git.

### Jenkins

Jenkins credentials are stored in AWS Systems Manager Parameter Store rather than being written directly into the repository or configuration files.

## GitHub workflow

The repository uses a Pull Request based workflow for protected branches.

The project also includes:

- Issue templates for bugs, features and tasks
- GitHub Projects / Kanban board
- Branch protection and PR rules

The general workflow is:

```text
Create branch
     |
     v
Make changes
     |
     v
Commit
     |
     v
Push branch
     |
     v
Open Pull Request
     |
     v
Review
     |
     v
Merge
```

## Verification

Some of the infrastructure and server configuration was checked directly from the environment.

### Docker

```bash
docker --version
```

### Docker Compose

```bash
docker compose version
```

### Python

```bash
python3 --version
```

### UFW

```bash
sudo ufw status
```

### Fail2Ban

```bash
sudo systemctl is-active fail2ban
```

### Terraform state locking

```bash
aws dynamodb describe-table   --table-name cloud-devops-tf-lock   --query 'Table.TableStatus'
```

Expected table status:

```text
ACTIVE
```

### Terraform state bucket

```bash
aws s3api head-bucket   --bucket cloud-devops-tf-state-ayesha
```

S3 versioning is enabled on the Terraform state bucket.

---

## Notes

This is a lab project for practicing cloud infrastructure, automation and basic security controls with AWS, Terraform and Ansible.
