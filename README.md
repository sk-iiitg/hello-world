# Prometheus and VictoriaMetrics Deployment on GCP/AWS

This project automates the installation of **Prometheus** and **VictoriaMetrics** using **Packer**. The created images are deployed on **Google Cloud Platform (GCP)** and **Amazon Web Services (AWS)** using **Terraform**. Additionally, manual changes are performed to enable **Let's Encrypt** for SSL certificates.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Build Image](#build-image)
- [Deploy to  GCP](#deploy-on-gcp)
- [Deploy to AWS](#deploy-on-aws)
- [Manual Configuration](#manual-configuration)

## Prerequisites

Before you begin, ensure you have the following tools installed:

- [Packer](https://www.packer.io/downloads)
- [Terraform](https://www.terraform.io/downloads.html)
- [gcloud CLI](https://cloud.google.com/sdk/docs/install)
- An **AWS** account with the appropriate permissions

##  Build Image
```bash
cd qa-metrics-exporter/packer 
AWS_PROFILE=yugabyte-sdet packer build prometheus-victoria.pkr.hcl
```
## Deploy on GCP 
### 1. Navigate to the Terraform configuration for GCP

```bash 
cd ../terraform/gcp
terraform init
terraform apply
```

### 2. Access the GCP Instance
SSH into the GCP instance using the following command:
```bash
gcloud compute ssh --zone "asia-south1-a" "qa-prometheus-victoria-metrics-exporter" --tunnel-through-iap --project "yugabyte-sdet"
```

### 3. Enable Services
```bash
sudo systemctl start victoriametrics
sudo systemctl start prometheus
sudo systemctl start nginx
sudo tailscale up --ssh
```
## Deploy on AWS
### 1. Navigate to the Terraform configuration for AWS
```bash 
cd ../terraform/aws
terraform init
terraform apply
```
### 2. Access the AWS Instance
```bash
To do
```
## Manual Configuration
To configure SSL certificates and set up DNS records, follow these steps:

### 1. Switch to Root User
```bash
sudo su
```

### 2. Set AWS Credentials
```bash
export AWS_ACCESS_KEY=XXXX  # Replace XXXX with your actual AWS Access Key
export AWS_SECRET_KEY=XXX    # Replace XXX with your actual AWS Secret Key
```

### 3. Generate SSL Certificates with Certbot
Use Certbot to generate SSL certificates for your domains. Run the following commands to create certificates for all required endpoints:
```bash
certbot certonly -a dns-route53 -d gcp-qa-prometheus-export.devcloud.yugabyte.com --agree-tos --non-interactive --no-eff-email --email cloud-ops@yugabyte.com
certbot certonly -a dns-route53 -d gcp-qa-victoria-export.devcloud.yugabyte.com --agree-tos --non-interactive --no-eff-email --email cloud-ops@yugabyte.com
certbot certonly -a dns-route53 -d internal-gcp-qa-prometheus-export.devcloud.yugabyte.com --agree-tos --non-interactive --no-eff-email --email cloud-ops@yugabyte.com
certbot certonly -a dns-route53 -d internal-gcp-qa-victoria-export.devcloud.yugabyte.com --agree-tos --non-interactive --no-eff-email --email cloud-ops@yugabyte.com
```

### 4. Create DNS Records in AWS
After generating the SSL certificates, you will need to create the necessary DNS records in your YugaByte AWS account:

- **For internal access**:
  - **Domains**: `internal-gcp-qa-prometheus-export.devcloud.yugabyte.com` and `internal-gcp-qa-victoria-export.devcloud.yugabyte.com`
  - **Record Type**: A record
  - **Value**: Use the private IP of the GCP instance. This endpoint will only be accessible from the YugaByte Metrics (YBM) cluster.

- **For external access**:
  - **Domains**: `gcp-qa-prometheus-export.devcloud.yugabyte.com` and `gcp-qa-victoria-export.devcloud.yugabyte.com`
  - **Record Type**: A record
  - **Value**: Use the Tailscale IP. This endpoint will be accessible to YBM engineers.
