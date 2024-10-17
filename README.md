# Prometheus and VictoriaMetrics Deployment on GCP/AWS

This project automates the installation of **Prometheus** and **VictoriaMetrics** using **Packer**. The created images are deployed on **Google Cloud Platform (GCP)** and **Amazon Web Services (AWS)** using **Terraform**. Additionally, manual changes are performed to enable **Let's Encrypt** for SSL certificates.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation of GCP instance](#3-deploy-the-gcp-machine)
- [Installation of AWS instance](#awsinstallation)
- [Manual Configuration](#manual-configuration)

## Prerequisites

Before you begin, ensure you have the following tools installed:

- [Packer](https://www.packer.io/downloads)
- [Terraform](https://www.terraform.io/downloads.html)
- [gcloud CLI](https://cloud.google.com/sdk/docs/install)
- **AWS** and **GCP** account with admin access to yugabyte-sdet account and yugabyte-cloud-dev account.

### 1. Clone the Repository
```bash
git clone git@github.com:yugabyte/qa-infra.git
cd qa-infra
```
### 2. Build the Image
Use Packer to build the images that contain Prometheus, VictoriaMetrics, and Nginx.:
```bash
cd qa-metrics-exporter/pakcer
AWS_PROFILE=yugabyte-sdet packer build prometheus-victoria.pkr.hcl
```

### 3. Deploy the GCP machine 
Navigate to the Terraform configuration for GCP:
```bash

cd ../terraform/gcp
terraform init
terraform workspace select <env> # Use env as  "qa" to deploy QA instance in yugabyte-sdet account and "dev" to deploy DEV instance on yugabyte-cloud-dev account 
terraform apply
```

### 4. Access the GCP Instance
SSH into the GCP instance using the following command:
```bash
gcloud compute ssh --zone "asia-south1-a" "<env>-prometheus-victoria-metrics-exporter" --tunnel-through-iap --project "yugabyte-sdet" # env could be dev or qa
```
### 5. Enable Services
```bash
sudo systemctl start victoriametrics
sudo systemctl start prometheus
sudo systemctl start nginx
sudo tailscale up --ssh --accept-routes
```
### Manual Configuration
#### 1. Generate ssl certificates
```bash
sudo su
export AWS_ACCESS_KEY=XXXX  # Get these from the YugaByte dev account IAM named metrics-exporter
export AWS_SECRET_KEY=XXX  
# Replace env with dev or qa based on instance type
certbot certonly -a dns-route53 -d gcp-<env>-prometheus-export.devcloud.yugabyte.com --agree-tos --non-interactive --no-eff-email --email cloud-ops@yugabyte.com
certbot certonly -a dns-route53 -d gcp-<env>-victoria-export.devcloud.yugabyte.com --agree-tos --non-interactive --no-eff-email --email cloud-ops@yugabyte.com
certbot certonly -a dns-route53 -d internal-gcp-<env>-prometheus-export.devcloud.yugabyte.com --agree-tos --non-interactive --no-eff-email --email cloud-ops@yugabyte.com
certbot certonly -a dns-route53 -d internal-gcp-<env>-victoria-export.devcloud.yugabyte.com --agree-tos --non-interactive --no-eff-email --email cloud-ops@yugabyte.com
```

#### 2. Configure Nginx
Copy the nginx.conf.dev file to /etc/nginx/nginx.conf for dev instance and nginx.conf.qa for qa instance
After generating the SSL certificates, you will need to create the necessary DNS records in your yugaByte-dev AWS account:

For internal access:

Domains: internal-gcp-<env>-prometheus-export.devcloud.yugabyte.com and internal-gcp-<env>-victoria-export.devcloud.yugabyte.com
Record Type: A record
Value: Use the private IP of the GCP instance. This endpoint will only be accessible from the YugaByte Metrics (YBM) cluster.
For external access:

Domains: gcp-<env>-prometheus-export.devcloud.yugabyte.com and gcp-<env>-victoria-export.devcloud.yugabyte.com
Record Type: A record
Value: Use the Tailscale IP. This endpoint will be accessible to YBM engineers.


