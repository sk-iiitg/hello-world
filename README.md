 Prometheus and VictoriaMetrics Deployment on GCP/AWS

This project automates the installation of **Prometheus** and **VictoriaMetrics** using **Packer**. The created images are deployed on **Google Cloud Platform (GCP)** and **Amazon Web Services (AWS)** using **Terraform**. Additionally, manual changes are performed to enable **Let's Encrypt** for SSL certificates.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Deployment](#deployment)
- [Manual Configuration](#manual-configuration)

## Prerequisites

Before you begin, ensure you have the following tools installed:

- [Packer](https://www.packer.io/downloads)
- [Terraform](https://www.terraform.io/downloads.html)
- [gcloud CLI](https://cloud.google.com/sdk/docs/install)
- An **AWS** account with the appropriate permissions

## Installation

### 1. Clone the Repository
```bash
git clone git@github.com:yugabyte/qa-infra.git
```
### 2. Build the Image
Use Packer to build the images that contain Prometheus, VictoriaMetrics, and Nginx, along with the necessary certificates:
```bash
cd qa-metrics-exporter/pakcer
AWS_PROFILE=yugabyte-sdet packer build prometheus-victoria.pkr.hcl
```

### 3. Deploy on GCP
Navigate to the Terraform configuration for GCP:
```bash 
cd ../terraform/gcp
terraform init
terraform apply
```

### 4. Access the GCP Instance
SSH into the GCP instance using the following command:
```bash
gcloud compute ssh --zone "asia-south1-a" "qa-prometheus-victoria-metrics-exporter" --tunnel-through-iap --project "yugabyte-sdet"
```
### 5. Enable Services
```bash
sudo systemctl start victoriametrics
sudo systemctl start prometheus
sudo systemctl start nginx
sudo tailscale up --ssh
```
## Manual Configuration
```bash
sudo su
export AWS_ACCESS_KEY=XXXX  # Get these from the YugaByte dev account IAM named metrics-exporter
export AWS_SECRET_KEY=XXX  
certbot certonly -a dns-route53 -d gcp-qa-prometheus-export.devcloud.yugabyte.com --agree-tos --non-interactive --no-eff-email --email cloud-ops@yugabyte.com
