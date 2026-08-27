Automated Deployment Service

## Overview

Automated Deployment Service is a DevOps project that demonstrates how to deploy a web application to AWS and automate application delivery with GitHub Actions.

The project combines Terraform, AWS EC2, Docker, Nginx, and GitHub Actions to create an automated deployment workflow with a post-deployment health check.

## Architecture

```text
Developer
   |
   | git push
   v
GitHub Repository
   |
   v
GitHub Actions
   |
   | SSH deployment
   v
AWS EC2 (Ubuntu)
   |
   v
Docker Container
   |
   v
Nginx Reverse Proxy
   |
   v
Web Application
   |
   v
Health Check
```

## Technologies Used

- AWS EC2
- Terraform
- Docker
- Nginx
- GitHub Actions
- Git / GitHub
- Ubuntu Linux
- Bash / Shell scripting

## Project Structure

```text
automated-deployment-service/
├── app/
│   └── index.html
├── docker/
│   └── Dockerfile
├── monitoring/
│   └── health-check.sh
├── terraform/
│   ├── main.tf
│   ├── providers.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars
├── .github/
│   └── workflows/
│       └── deploy.yml
└── README.md
```

## Infrastructure

Terraform is used to provision and manage the AWS infrastructure required for the deployment server.

The deployment environment includes an AWS VPC, public subnet, security group, and EC2 instance.

Terraform outputs include the EC2 deployment server ID and public IP address.

## Docker

The application is packaged as a Docker image using Nginx as the base image.

The Dockerfile:

- Uses `nginx:alpine`
- Copies the application into Nginx's web root
- Exposes port 80

The container is published on the EC2 host through port 8080.

## Nginx

Nginx runs on the EC2 server as a reverse proxy.

Incoming HTTP traffic on port 80 is forwarded to the Docker application on port 8080.

```text
Internet
   |
   | HTTP :80
   v
Nginx
   |
   | proxy_pass
   v
Docker :8080
   |
   v
Application :80
```

## CI/CD Pipeline

GitHub Actions is configured to deploy whenever changes are pushed to the `main` branch.

The workflow:

1. Checks out the repository.
2. Connects to the EC2 server through SSH.
3. Synchronizes the EC2 repository with `origin/main`.
4. Builds the Docker image.
5. Replaces the running application container.
6. Starts the new container.
7. Waits briefly for the application to start.
8. Runs a health check.
9. Reports the deployment as successful only when the health check passes.

## Health Check

The deployment workflow verifies the application using:

```bash
curl -f http://localhost:8080/
```

A separate monitoring script is also included at:

```text
monitoring/health-check.sh
```

The script checks whether the application responds successfully and returns a failure status if the application is unavailable.

## Deployment Result

The deployment pipeline has been successfully tested through GitHub Actions.

Successful workflow runs demonstrate:

```text
Git Push
   ↓
GitHub Actions
   ↓
EC2
   ↓
Docker Build
   ↓
Container Deployment
   ↓
Nginx
   ↓
Health Check
   ↓
Deployment Successful
```

## Security

Sensitive credentials are not stored directly in the workflow file.

The GitHub Actions deployment uses repository secrets for:

- EC2 host
- EC2 username
- EC2 SSH private key

Private keys, passwords, and secret values should never be committed to the repository.

## Lessons Learned

This project provided practical experience with:

- Infrastructure as Code using Terraform
- AWS EC2 provisioning
- Linux server administration
- Docker containerization
- Nginx reverse proxy configuration
- GitHub Actions CI/CD
- SSH-based automated deployments
- Application health checks
- Debugging failed deployments
- Keeping infrastructure and application configuration synchronized

## Future Improvements

Possible future improvements include:

- HTTPS with a domain and Let's Encrypt
- Stronger deployment rollback strategy
- Centralized monitoring and alerting
- Better secret management
- Deployment environments and approval gates
- Blue/green or rolling deployment strategy
- Automated infrastructure validation

## Author

Adepomola Ayomide
