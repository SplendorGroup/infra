variable "name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "intra_subnets" {
  description = "List of intra subnet IDs"
  type        = list(string)
}

variable "desired_size" {
  description = "Desired size for the EKS node group"
  type        = number
}

variable "max_size" {
  description = "Maximum size for the EKS node group"
  type        = number
}

variable "min_size" {
  description = "Minimum size for the EKS node group"
  type        = number
}

variable "ami_type" {
  description = "AMI type for the EKS node group"
  type        = string
}

variable "instance_types" {
  description = "Instance types for the EKS node group"
  type        = list(string)
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

variable "security_groups" {
  
}

variable "cluster_role_arn" {
  
}

variable "node_role_arn" {
  
}