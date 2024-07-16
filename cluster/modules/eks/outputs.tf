output "cluster_id" {
  value = module.eks.cluster_id
}

output "node_security_group" {
  value = module.eks.node_security_group_id
}

output "endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_ca_certificate" {
  value = module.eks.cluster_certificate_authority_data
}