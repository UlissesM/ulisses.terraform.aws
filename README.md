# E-commerce Microservices Infrastructure

This project sets up a complete AWS infrastructure for an e-commerce platform using Terraform. It includes ECS services, API Gateways, DynamoDB tables, and networking components for multiple microservices.

## Prerequisites

- AWS CLI configured with appropriate permissions (https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- Terraform (https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- Docker (for local testing of the application)(https://docs.docker.com/engine/install/)

## AWS Credentials Setup

For security reasons, we use environment variables to set AWS credentials. This approach prevents sensitive information from being stored in files that might accidentally be committed to version control.

Set up your AWS credentials as environment variables before running Terraform:

```bash
export AWS_ACCESS_KEY_ID="your_access_key"
export AWS_SECRET_ACCESS_KEY="your_secret_key"
export AWS_DEFAULT_REGION="us-east-1"  
```

For Windows PowerShell, use:

```powershell
$env:AWS_ACCESS_KEY_ID="your_access_key"
$env:AWS_SECRET_ACCESS_KEY="your_secret_key"
$env:AWS_DEFAULT_REGION="us-east-1"
```

These environment variables will be automatically used by Terraform when interacting with AWS.

Important: Never store your AWS credentials in any files that are part of your project repository.

## Configuration Files

The `dev.tfvars` file in this project does not contain any sensitive information or secret values. It includes only non-sensitive configuration data such as resource names, sizes, and other public settings. All sensitive data, including API keys and secrets, should be managed securely outside of this file, preferably using AWS Secrets Manager or similar services in a production environment.

## Configuration Details (dev.tfvars)

The `env_configs/dev.tfvars` file contains the configuration for development environment.

### Sample dev.tfvars
```hcl
# General
region      = "us-east-1"
environment = "dev"

# VPC Configuration
vpc_cidr = "10.0.0.0/22" # Provides 1024 IP addresses

# Subnet Configuration
public_subnet_cidrs  = ["10.0.0.0/24", "10.0.1.0/24"]
private_subnet_cidrs = ["10.0.2.0/24", "10.0.3.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]

# ECS Services
services = {
  users = {
    name              = "users-service"
    container_name    = "users-service"
    image             = "ulsmaia/sample-api:latest"
    cpu               = 256
    memory            = 512
    desired_count     = 2
    container_port    = 5000
    service_port      = 5000
    health_check_path = "/health"
    environment_variables = {
      PORT         = "5000"
      SERVICE_NAME = "users-service"
    }
    dynamodb_hash_key  = "user_id"
    dynamodb_range_key = "email"
  },
  # ... services (products, orders, inventory, payments) ...
}
```

### Key Points and Customization:

1. **Region**: The infrastructure is set up in `us-east-1`. Modify this if you need to deploy in a different region.

2. **VPC CIDR**: The VPC is configured with a `/22` CIDR block, providing 1024 IP addresses. Adjust this if you need a larger or smaller address space.

3. **Subnets**: Two public and two private subnets are defined across two availability zones. Ensure this meets your high availability requirements.

4. **Services**: 
   - All services use the same Docker image (`ulsmaia/sample-api:latest`). This can be replaced with specific images for each service.
   - Each service is allocated 256 CPU units and 512 MB of memory. Adjust these based on your application needs.
   - The `desired_count` is set to 2 for each service, providing basic redundancy. Increase this for higher availability or to handle more traffic.
   - Each service uses a different port (5000, 3000, 5050, 5010, 5005). Ensure these align with your application configurations.
   - Health check paths are set to `/health` for all services. Customize these if your services use different health check endpoints.

5. **DynamoDB Configuration**: Each service has its own DynamoDB table configuration with specified hash and range keys. Modify these to match your data model requirements.

6. **Environment Variables**: The `PORT` and `SERVICE_NAME` environment variables are set for each service. Add any additional environment variables your services require.


## Setup and Deployment

1. Clone the repository:
   ```
   git clone https://github.com/UlissesM/ulisses.terraform.aws.git
   cd ulisses.terraform.aws
   ```

2. Ensure your AWS credentials are set as environment variables (see AWS Credentials Setup section).

3. Initialize Terraform:
   ```
   terraform init
   ```

4. Review the `env_configs/dev.tfvars` file. This file contains non-sensitive configuration values. You may modify these as needed, but remember not to add any sensitive information to this file.

5. Plan the Terraform execution:
   ```
   terraform plan -var-file=env_configs/dev.tfvars
   ```

6. Apply the Terraform configuration:
   ```
   terraform apply -var-file=env_configs/dev.tfvars
   ```

7. After successful application, the outputs will display the API Gateway endpoints for each service.

## Testing the Endpoints

The Terraform output provides URLs for each service's health and test endpoints. Here's how to test them:

1. Health Check (No API Key required):
   ```
   curl https://[api-id].execute-api.us-east-1.amazonaws.com/dev/health
   ```

2. Test Endpoint (API Key required):
   First, retrieve the API key from the AWS API Gateway console. Then:
   ```
   curl -H "x-api-key: [YOUR_API_KEY]" https://[api-id].execute-api.us-east-1.amazonaws.com/dev/test
   ```

   Example:
   ```
   curl -H "x-api-key: abcdefghij123456789" https://cw5shzwy7.execute-api.us-east-1.amazonaws.com/dev/test
   ```

## Application Folder

The `application` folder contains a sample API that serves as a placeholder for the actual microservices. This folder is included in the project to provide a basic application structure that can be deployed to ECS

The contents of the `application` folder are:

- `Dockerfile`: Defines how to build the Docker image for the application.
- `main.py`: A simple Python application using Flask, providing `/health` and `/test` endpoints.
- `requirements.txt`: Lists the Python dependencies for the application.

### Running the Application Locally

To run the application locally:

1. Navigate to the application directory:
   ```
   cd application
   ```

2. Build the Docker image:
   ```
   docker build -t sample-api .
   ```

3. Run the container:
   ```
   docker run -p 5000:5000 sample-api:latest
   ```

4. The API will be accessible at `http://localhost:5000`

You can test the local endpoints using:
```
curl http://localhost:5000/health
curl http://localhost:5000/test
```

Note: This same image is available on Docker Hub as a public image and is used as the default image for ECS containers in this project. In a real-world scenario, you would replace this with your actual microservice images.

## Infrastructure Components

- **Networking**: VPC, subnets, internet gateway, NAT gateway
- **ECS**: Fargate cluster and services for each microservice
- **API Gateway**: Separate API Gateways for each service with health and test endpoints
- **DynamoDB**: Tables for each service
- **NLB**: Network Load Balancer for routing traffic to ECS services

## Cleanup

To destroy the infrastructure and clean up all created resources:

```
terraform destroy -var-file=env_configs/dev.tfvars
```

This command will remove all resources created by Terraform in your AWS account. You will be prompted to confirm the destruction of resources. Type 'yes' to proceed.

Caution: This action is irreversible and will delete all data stored in the created resources. Ensure you have backups of any important data before proceeding.

## Security Notes

- The `dev.tfvars` file does not contain any sensitive information. All sensitive data (like API keys, database passwords, etc.) should be managed securely, preferably using AWS Secrets Manager or similar services.
- Always ensure that files containing sensitive information (like `.env` files or files with AWS credentials) are listed in `.gitignore` to prevent accidental commits.

## Troubleshooting

- If you encounter issues with API Gateway, check the CloudWatch logs for each service.
- For ECS-related problems, review the ECS console and check the task definitions and service logs.
- Ensure your AWS CLI is properly configured with the correct permissions.
- If resources fail to destroy, you may need to manually delete some resources in the AWS console and retry the destroy command.

## Future Enhancements

### 1. AWS ECR for Container Registry

Currently, the project uses public Docker Hub images. A more secure and manageable approach would be to use Amazon Elastic Container Registry (ECR):

- Create ECR repositories for each microservice
- Update the Terraform code to create and manage ECR repositories
- Modify the CI/CD pipeline to build and push images to ECR
- Update the ECS task definitions to pull images from ECR

### 2. Auto-scaling for ECS Services

Implement auto-scaling to dynamically adjust the number of tasks based on CPU utilization or custom metrics:

- Add Application Auto Scaling resources in Terraform
- Configure scaling policies based on CPU utilization or custom CloudWatch metrics
- Set up CloudWatch alarms to trigger scaling actions

### 3. Terraform Backend Configuration

To enable team collaboration and maintain state consistency, configure a remote backend using S3 for state storage and DynamoDB for state locking:

1. Create an S3 bucket and DynamoDB table for Terraform state.

2. Configure the backend in  `backend.tf` file.

### 4. Additional Enhancements to Consider

- Implement more robust monitoring and alerting using CloudWatch
- Implement CI/CD pipelines for automated deployments
