# Multi-Environment Infrastructure as Code (IaC) Project

A comprehensive Infrastructure as Code solution for provisioning and configuring multi-environment AWS infrastructure using Terraform and Ansible.

## 🏗️ Architecture

![Project Architecture](images/Project-design.gif)

## 📋 Overview

This project automates the deployment and configuration of AWS infrastructure across multiple environments (Development, Staging, and Production) using a combination of:
- **Terraform** - Infrastructure provisioning
- **Ansible** - Configuration management and application deployment

## ✨ Features

- 🚀 **Multi-Environment Support**: Separate configurations for Dev, Staging, and Production
- 🔄 **Modular Design**: Reusable Terraform modules for consistent infrastructure
- 📦 **Automated Provisioning**: EC2 instances, S3 buckets, and DynamoDB tables
- ⚙️ **Configuration Management**: Automated Nginx installation and configuration via Ansible
- 🔐 **Security**: Configured security groups with SSH, HTTP, and HTTPS access
- 📊 **State Management**: Remote state storage using S3 and DynamoDB for state locking

## 🛠️ Technologies Used

- **Terraform** v1.0+
- **Ansible** v2.9+
- **AWS** (EC2, S3, DynamoDB, VPC)
- **Nginx** (Web server)

## 📁 Project Structure

```
Multi-Env-IaC/
├── terraform/
│   ├── main.tf                 # Main configuration with environment modules
│   ├── providers.tf            # AWS provider configuration
│   ├── terraform.tf            # Terraform backend configuration
│   └── infra/
│       ├── ec2.tf             # EC2 instances and security groups
│       ├── bucket.tf          # S3 bucket configuration
│       ├── dynamodb.tf        # DynamoDB table for state locking
│       ├── variable.tf        # Input variables
│       └── output.tf          # Output values
├── ansible/
│   ├── inventories/
│   │   ├── dev                # Development environment inventory
│   │   ├── stg                # Staging environment inventory
│   │   └── prod               # Production environment inventory
│   ├── playbooks/
│   │   ├── install_nginx_playbook.yml
│   │   └── nginx-role/        # Ansible role for Nginx installation
│   └── update_inventories.sh  # Script to update inventory files
└── images/
    └── Project-design.gif     # Architecture diagram
```

## 🌍 Environment Configuration

| Environment | Instance Count | Instance Type | Volume Size |
|------------|---------------|---------------|-------------|
| Development | 2             | t2.micro      | 8 GB        |
| Staging     | 2             | t2.micro      | 8 GB        |
| Production  | 3             | t2.micro      | 8 GB        |

## 🚀 Getting Started

### Prerequisites

1. **AWS Account** with appropriate permissions
2. **AWS CLI** configured with credentials
3. **Terraform** installed (v1.0 or higher)
4. **Ansible** installed (v2.9 or higher)
5. **SSH Key Pair** generated (`devops-key` and `devops-key.pub`)

### Installation Steps

#### 1. Clone the Repository

```bash
git clone <repository-url>
cd Multi-Env-IaC
```

#### 2. Generate SSH Key Pair

```bash
ssh-keygen -t rsa -b 4096 -f devops-key
```

Place the `devops-key.pub` file in the `terraform/infra/` directory.

#### 3. Configure AWS Credentials

```bash
aws configure
```

Enter your AWS Access Key ID, Secret Access Key, default region, and output format.

## 📦 Terraform Deployment

### Initialize Terraform

```bash
cd terraform
terraform init
```

### Plan Infrastructure

```bash
terraform plan
```

### Deploy Infrastructure

Deploy all environments:
```bash
terraform apply
```

Or deploy specific environment:
```bash
terraform apply -target=module.dev-infra
terraform apply -target=module.stg-infra
terraform apply -target=module.prod-infra
```

### Get Output Values

```bash
terraform output
```

This will display the public IP addresses of all provisioned instances.

## ⚙️ Ansible Configuration

### Update Inventory Files

After deploying infrastructure with Terraform, update the Ansible inventory files with the instance IP addresses:

```bash
cd ansible
./update_inventories.sh
```

Or manually edit the inventory files:
- `ansible/inventories/dev`
- `ansible/inventories/stg`
- `ansible/inventories/prod`

### Update SSH Key Path

Edit the inventory files to update the `ansible_ssh_private_key_file` path to your local key location.

### Run Ansible Playbook

Install and configure Nginx on Development environment:
```bash
cd ansible
ansible-playbook -i inventories/dev playbooks/install_nginx_playbook.yml
```

For Staging:
```bash
ansible-playbook -i inventories/stg playbooks/install_nginx_playbook.yml
```

For Production:
```bash
ansible-playbook -i inventories/prod playbooks/install_nginx_playbook.yml
```

### Verify Deployment

After running the playbook, visit the public IP addresses of your instances in a web browser:
```
http://<instance-public-ip>
```

You should see the Nginx welcome page.

## 🔍 Key Components

### Terraform Modules

- **EC2 Module**: Provisions EC2 instances with:
  - Dynamic AMI selection (Ubuntu)
  - Security groups (SSH, HTTP, HTTPS)
  - SSH key pair management
  - Customizable instance count and type per environment

- **S3 Module**: Creates S3 buckets for:
  - Terraform state storage
  - Environment-specific resources

- **DynamoDB Module**: Creates DynamoDB tables for:
  - Terraform state locking
  - Preventing concurrent modifications

### Ansible Roles

- **nginx-role**: Complete Nginx installation and configuration
  - Package installation
  - Service management
  - Custom index.html deployment
  - Handler-based service restart

## 🔐 Security Considerations

- SSH keys are not committed to version control
- Security groups restrict access to necessary ports only
- Remote state is secured in S3 with DynamoDB locking
- Ansible uses secure SSH connections with key-based authentication

## 🧹 Cleanup

To destroy all infrastructure:

```bash
cd terraform
terraform destroy
```

To destroy specific environment:
```bash
terraform destroy -target=module.dev-infra
```

## 📝 Customization

### Modify Environment Configuration

Edit [`terraform/main.tf`](terraform/main.tf) to adjust:
- Instance count
- Instance type
- Volume size
- Environment names

### Modify Infrastructure Components

Edit files in [`terraform/infra/`](terraform/infra/) to customize:
- Security group rules ([`ec2.tf`](terraform/infra/ec2.tf))
- S3 bucket configuration ([`bucket.tf`](terraform/infra/bucket.tf))
- DynamoDB settings ([`dynamodb.tf`](terraform/infra/dynamodb.tf))

### Modify Ansible Configuration

Edit [`ansible/playbooks/nginx-role/`](ansible/playbooks/nginx-role/) to customize:
- Nginx configuration
- Custom web content
- Additional packages or services

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👥 Authors

Shahid Khan - DevOps Engineer

## 🙏 Acknowledgments

- Terraform documentation
- Ansible documentation
- AWS best practices
- DevOps community

## 📞 Support

For issues, questions, or contributions, please open an issue in the repository.

---

**Note**: Remember to update sensitive information like IP addresses and SSH key paths before committing changes to version control.
