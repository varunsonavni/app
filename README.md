# Northwind E-Commerce Infrastructure

Production-ready, 2-tier AWS infrastructure built with Terraform.

## Architecture

```
                    ┌─────────────────────────────────────────────┐
                    │                    VPC                       │
                    │              192.168.0.0/16                  │
                    │                                             │
  Internet ──── IGW ──┬── Public Subnet A ──┬── ALB ────────────┐│
                    │  └── Public Subnet B ──┘                   ││
                    │                                            ││
                    │  ┌── Private Subnet A ──┬── ASG (Nginx) ◄─┘│
                    │  └── Private Subnet B ──┤                   │
                    │         NAT GW ◄────────┤                   │
                    │                         └── RDS PostgreSQL  │
                    └─────────────────────────────────────────────┘
```

## Modules

| Module       | Description                                          |
|-------------|------------------------------------------------------|
| `networking` | VPC, subnets, IGW, NAT Gateway, route tables         |
| `database`   | RDS PostgreSQL with security groups and subnet group |
| `compute`    | ALB, Launch Template, Auto Scaling Group             |

## Prerequisites

- Terraform >= 1.10.0
- AWS CLI configured with valid credentials
- AWS account with sufficient permissions

## Usage

```bash
# Initialize Terraform
terraform init

# Review the execution plan
terraform plan -var="db_username=admin" -var="db_password=YourSecurePassword"

# Apply the configuration
terraform apply -var="db_username=admin" -var="db_password=YourSecurePassword"

# Destroy all resources
terraform destroy -var="db_username=admin" -var="db_password=YourSecurePassword"
```

Alternatively, export credentials as environment variables:

```bash
export TF_VAR_db_username="admin"
export TF_VAR_db_password="YourSecurePassword"
terraform plan
```

## Outputs

| Output          | Description                              |
|----------------|------------------------------------------|
| `vpc_id`       | ID of the provisioned VPC                |
| `db_endpoint`  | Connection endpoint for the RDS instance |
| `alb_dns_name` | DNS name of the Application Load Balancer|

## Security Highlights

- RDS deployed in private subnets, no public access
- Database accepts traffic only from VPC CIDR
- EC2 instances accept HTTP only from the ALB security group
- IMDSv2 enforced on all EC2 instances
- RDS storage encryption enabled
- NAT Gateway for private subnet outbound access
