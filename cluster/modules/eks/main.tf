module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.17.2"

  cluster_name                   = var.name
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access = true
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]

  cluster_tags = {
    "kubernetes.io/cluster/${var.name}" = null
  }

  cluster_addons = {
    vpc-cni = {
      most_recent = true
    }
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    aws-ebs-csi-driver = {
      most_recent = true
    }
  }


  iam_role_arn = var.cluster_role_arn
  vpc_id                   = var.vpc_id
  subnet_ids               = concat(var.private_subnets, var.public_subnets)
  control_plane_subnet_ids = concat(var.private_subnets, var.public_subnets)
  cluster_additional_security_group_ids = var.security_groups

  eks_managed_node_group_defaults = {
    ami_type       = var.ami_type
    instance_types = var.instance_types
  }

  eks_managed_node_groups = {
    splendor_node_group = {
      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size

      instance_types = var.instance_types
      capacity_type  = var.capacity_type

      iam_role_arn = var.node_role_arn

      tags = {
        Name = var.cluster_name_tag
      }
    }
  }

  tags = {
    Name        = var.name
    Environment = var.environment
  }
}
