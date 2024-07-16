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

variable "key_name" {
  description = "Key name for EC2 instances"
  type        = string
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
}

variable "enable_nat_gateway" {
  type =  bool
}

variable "single_nat_gateway" {
  type =  bool  
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
}

variable "intra_subnets" {
  description = "List of intra subnet IDs"
  type        = list(string)
}

variable "azs" {
  description = "Avaliable Zones"
  type        = list(string)
}


variable "instance_types" {
 type        = list(string)
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
}

variable "desired_capacity" {
  description = "Desired capacity for the EKS node group"
  type        = number
}

variable "max_capacity" {
  description = "Maximum capacity for the EKS node group"
  type        = number
}

variable "min_capacity" {
  description = "Minimum capacity for the EKS node group"
  type        = number
}

variable "ami_type" {
  description = "AMI type for the EKS node group"
  type        = string
}

variable "capacity_type" {
  description = "Capacity type for the EKS node group"
  type        = string
}

variable "cluster_name_tag" {
  description = "Tag for the cluster name"
  type        = string
}

variable "environment" {
  description = "Environment tag for the cluster"
  type        = string
}

variable "coredns_most_recent" {
  description = "Use the most recent version of CoreDNS addon"
  type        = bool
}

variable "kube_proxy_most_recent" {
  description = "Use the most recent version of kube-proxy addon"
  type        = bool
}

variable "vpc_cni_most_recent" {
  description = "Use the most recent version of VPC CNI addon"
  type        = bool
}

variable "attach_cluster_primary_security_group" {
  description = "Attach cluster primary security group"
  type        = bool
}

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID"
  type = string
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type = string
}