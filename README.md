# Portfolio-Projects-Cloud

StartupCo IAM Security Project
Implemented secure IAM for a startup that was sharing AWS management (root) account credentials. This project fixed security issues and set up proper role-based access control.
The Problem
StartupCo had a total of 10 people all using the same root account credentials that were shared in a non-secured way. This meant:

No way to track who did what
Everyone had full admin access to everything
No MFA or password requirements
One compromised credential = entire AWS account compromised

What I Built
Created an IAM setup with:

4 groups (developers, operations, finance, analysts)
10 individual user accounts
Least-privilege permissions for each group
MFA enforcement
CloudTrail logging for audit trails
Password policy (14 chars, complexity requirements, 90-day rotation)

Architecture
Root Account (secured, MFA enabled)
    ↓
IAM Groups
    ├─ Developers (4 users) → EC2 + S3 dev access
    ├─ Operations (2 users) → Full infrastructure access
    ├─ Finance (1 user) → Billing + read-only
    └─ Analysts (3 users) → Read-only data access
Key Security Features

MFA Required - Users can't do anything until they enable MFA
Tag-Based Access - Developers can only touch resources tagged "Environment=development"
CloudTrail Enabled - Full audit log of who did what
Strong Passwords - 14+ characters, expires every 90 days
S3 Bucket Policies - CloudTrail logs are encrypted and access-controlled

Files

main.tf - CloudTrail setup and S3 bucket for logs
iam-groups.tf - Creates the 4 IAM groups
iam-users.tf - Creates all 10 users
iam-policies.tf - Custom policies for each group
password-policy.tf - Account-wide password requirements
variables.tf - Configuration variables
outputs.tf - Useful outputs after deployment

How to Deploy
bash# Set up your variables
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your email

# Deploy
terraform init
terraform plan
terraform apply
Users Created
RoleUsersDevelopersdev-1, dev-2, dev-3, dev-4Operationsops-1, ops-2Financefinance-1Analystsanalyst-1, analyst-2, analyst-3
Permissions Summary
Developers

Can start/stop/reboot EC2 instances tagged with Environment=development
Read/write access to startupco-app-dev S3 bucket
View CloudWatch logs
Cannot touch production or delete buckets

Operations

Full EC2, RDS, S3, CloudWatch access
Can view IAM users but not create/delete them
Basically everything except IAM policy changes

Finance

View all AWS resources (read-only)
Full access to Cost Explorer and Budgets
Can't modify anything

Analysts

Read-only access to analytics S3 bucket
Can describe RDS instances
Cannot write, modify, or delete anything

What I Learned
Challenge: Getting the MFA policy correct was challenging. First attempt locked all IAM users out meaning they couldn't access the console to set up MFA.
Solution: Had to add exceptions for iam:GetUser and iam:ChangePassword so users could sign in and configure MFA.
Challenge: Figuring out the right level of permissions for developers - needed them to work effectively but not accidentally break production.
Solution: Used tag-based conditional access. They can only touch resources with the "development" environment tag.
Results

Eliminated shared root account usage
100% MFA adoption across all users
Full audit trail via CloudTrail
Reduced security risk significantly
Faster onboarding - new users set up in ~minutes instead of days

Tools Used

Terraform for infrastructure as code (IAC)
AWS IAM for identity management
CloudTrail for audit logging
SNS for security alerts


Travon Mayo
Email: travondm2@gmail.com
GitHub: https://github.com/vonongit/Portfolio-Projects-Cloud
LinkedIn: https://www.linkedin.com/in/travon-mayo/

Note: This was a learning project based on a scenario from Cloud Engineer Academy.

Resources: 
Terraform-AWS provider Documentation: https://registry.terraform.io/providers/hashicorp/aws/latest/docs
Knowledge from Cloud Engineer Academy, founded by Soleyman Sahir