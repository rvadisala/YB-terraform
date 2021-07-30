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
