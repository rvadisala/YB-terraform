# terraform plan --out tfplan.binary
# terraform show -json tfplan.binary > tfplan.json
# https://www.openpolicyagent.org/docs/latest/terraform/
# https://www.silect.is/blog/multi-cloud-vpn-terraform/


output "lb_name" {
  description = "URL of load balancer"
  value       = module.webserver_cluster.lb_name
}


output "db_address" {
  value = module.webserver_cluster.db_address
}

output "db_port" {
  value = module.webserver_cluster.db_port
}

output "db_engine" {
  value = module.webserver_cluster.db_engine
}


output "db_publicly_accessible" {
  value = module.webserver_cluster.db_publicly_accessible
}
