# terraform-strapi-private-ec2
Overview
This Terraform project deploys a secure AWS infrastructure with a private EC2 instance running Strapi CMS, accessible via an Application Load Balancer (ALB). The architecture follows AWS best practices with public/private subnet segregation.

Architecture
VPC with public and private subnets

Private EC2 Instance (in private subnet) running Strapi

NAT Gateway for outbound internet access from private instance

Application Load Balancer (in public subnet) for secure access

Security Groups for controlled network access

Auto-scaling for high availability

S3 Bucket for Strapi media storage

AWS Account with CLI credentials configured

Terraform v1.0+ installed

SSH key pair for EC2 access

Git for repository access

Repository Structure
terraform-aws-strapi/
├── modules/
│   ├── networking/     # VPC, subnets, NAT Gateway
│   ├── compute/        # EC2, Launch Template, Auto Scaling
│   ├── security/       # Security Groups, IAM roles
│   ├── loadbalancer/   # ALB, Target Groups, Listeners
│   └── storage/        # S3 bucket for Strapi
├── environments/
│   ├── dev/
│   │   ├── terraform.tfvars
│   │   └── backend.tf
│   └── prod/
│       ├── terraform.tfvars
│       └── backend.tf
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md

User Data Script
The EC2 instance automatically installs and configures Strapi on startup:

Updates system packages

Installs Docker and Docker Compose

Creates Docker Compose file for Strapi

Sets up environment variables

Deploys Strapi application

Configures S3 media provider

Access Points
Strapi Admin Panel: http://ALB-DNS-NAME:1337/admin

SSH Access: Via Session Manager or Bastion Host (if configured)

Application API: http://ALB-DNS-NAME:1337/api

Outputs
After deployment, Terraform outputs:

Load Balancer DNS name

EC2 instance IDs

S3 bucket name

VPC and subnet IDs

Maintenance
Update Infrastructure
bash
terraform apply -var-file=environments/dev/terraform.tfvars
Destroy Resources
bash
terraform destroy -var-file=environments/dev/terraform.tfvars
State Management
Backend configured in backend.tf

State stored in S3 bucket with DynamoDB locking

Security Notes
Private EC2 instances have no public IPs

Only ALB is internet-facing

Security groups restrict access to necessary ports only

IAM roles follow least-privilege principle

Database connection uses environment variables (not hardcoded)

Troubleshooting
Check CloudWatch Logs for instance initialization

Verify security group rules

Ensure NAT Gateway is in public subnet

Confirm ALB target group health checks

Variables Reference
See variables.tf for complete list of configurable parameters.
