# terraform plan --out tfplan.binary
# terraform show -json tfplan.binary > tfplan.json
# https://www.openpolicyagent.org/docs/latest/terraform/
# https://www.silect.is/blog/multi-cloud-vpn-terraform/


output "lb_name" {
  description = "URL of load balancer"
  value       = "http://${aws_lb.web_lb.dns_name}"
}

output "db_subnet_group_name" {
  value = module.vpc.database_subnets
}

output "vpc_name" {
  value = module.vpc.name
}

output "db_address" {
  description = "RDS Address"
  value       = module.db_rds.rds_address
}

output "db_endpoint" {
  description = "RDS ENDPOINT Address"
  value       = module.db_rds.rds_endpoint
}

output "db_engine" {
  description = "RDS Engine"
  value       = module.db_rds.rds_engine
}

output "db_port" {
  description = "RDS Port"
  value       = module.db_rds.rds_port
}

output "db_publicly_accessible" {
  description = "RDS Publicly Accessible"
  value       = module.db_rds.rds_publicly_accessible
}
