variable "cloudflare_email" {
  description = "Cloudflare account email"
  type        = string
}

variable "cloudflare_api_key" {
  description = "Cloudflare API key"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}


variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID"
  type = string
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type = string
}