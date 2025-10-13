🚀 Tech Stack

The main technologies and tools used in this project are:

    Cloud Provider:

        AWS

    Infrastructure as Code (IaC):

        Terraform

    Containerization:

        Docker (Application Containerization)

        AWS ECR (Container Image Registry)

        Kubernetes (AWS EKS) (Container Orchestration)

    CI/CD & Automation:

        GitHub & GitHub Actions

    Data Layer:

        AWS RDS (PostgreSQL)

    Networking & Security:

        AWS VPC, Subnet, NAT Gateway, IAM, Security Groups

    Application:

        Python (Flask)

✨ Core Infrastructure Features

    High Availability: The entire infrastructure (Subnets, RDS, EKS Nodes) is distributed across two different Availability Zones (AZs), making it resilient to single data center failures.

    Infrastructure as Code (IaC): All resources on AWS (VPC, EKS, RDS, etc.) are managed declaratively using Terraform. This ensures the infrastructure is repeatable, versionable, and auditable.

    Fully Automated CI/CD Pipeline: Every push to the main branch triggers a GitHub Actions workflow that automatically performs the following steps:

        A Docker image is built.

        The created image is pushed to AWS ECR.

        The new image is automatically deployed to the Kubernetes (EKS) cluster.

    Security-Focused Design:

        The database and application servers run in Private Subnets, isolated from the public internet.

        AWS IAM roles are configured following the "Principle of Least Privilege" to ensure services have only the permissions they need.

        The connection between GitHub Actions and AWS is established using OIDC, a modern and secure passwordless authentication method.

🛠️ Setup and Usage

    Prerequisites:

        An AWS Account

        AWS CLI (configured)

        Terraform

        Git

    Provisioning the Infrastructure:

    # To initialize providers
    terraform init

    # To provision the infrastructure
    terraform apply

    Destroying the Infrastructure:

    # To destroy all resources
    terraform destroy

