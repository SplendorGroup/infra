provider "aws" {
  region = var.aws_region
}

module "iam" {
  source = "./modules/iam"
  cluster_name = var.cluster_name
  aws_account_id = var.aws_account_id 
}

module "vpc" {
  source  = "./modules/vpc"
  name           = var.vpc_name
  cidr           = var.vpc_cidr
  azs            = var.azs
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway
  cluster_name = var.cluster_name
  depends_on = [module.iam]
}

module "security_groups" {
  source  = "./modules/security_groups"
  vpc_id  = module.vpc.vpc_id
  depends_on = [module.vpc]
}

module "eks" {
  source          = "./modules/eks"
  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
  private_subnets = module.vpc.private_subnets
  intra_subnets = var.intra_subnets
  instance_types = var.instance_types
  security_groups = [module.security_groups.eks_sg]
  name            = var.cluster_name
  cluster_version = var.cluster_version
  ami_type        = var.ami_type
  min_size        = var.min_capacity
  max_size        = var.max_capacity
  desired_size    = var.desired_capacity
  capacity_type   = var.capacity_type
  cluster_name_tag = var.cluster_name_tag
  environment     = var.environment
  coredns_most_recent = var.coredns_most_recent
  kube_proxy_most_recent = var.kube_proxy_most_recent
  vpc_cni_most_recent = var.vpc_cni_most_recent
  attach_cluster_primary_security_group = var.attach_cluster_primary_security_group
  cluster_role_arn = module.iam.eks_cluster_role_arn
  node_role_arn = module.iam.eks_node_role_arn
  depends_on = [module.vpc, module.security_groups, module.iam]
}