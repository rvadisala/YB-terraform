# terraform plan --out tfplan.binary
# terraform show -json tfplan.binary > tfplan.json
# https://www.openpolicyagent.org/docs/latest/terraform/
# https://www.silect.is/blog/multi-cloud-vpn-terraform/


output "lb_name" {
  description = "URL of load balancer"
  value       = module.webserver_cluster.lb_name
}
