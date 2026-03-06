################################################################################
# Networking
################################################################################

output "vpc_id" {
  description = "ID of the provisioned VPC"
  value       = module.networking.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.networking.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = module.networking.private_subnet_ids
}

################################################################################
# Database
################################################################################

output "db_endpoint" {
  description = "Connection endpoint of the RDS instance"
  value       = module.database.db_endpoint
}

################################################################################
# Compute
################################################################################

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.compute.alb_dns_name
}
