output "rds_address" {
  description = "RDS Address"
  value       = aws_db_instance.tf-mysql-db-rds.address
}

output "rds_endpoint" {
  description = "RDS ENDPOINT Address"
  value       = aws_db_instance.tf-mysql-db-rds.endpoint
}

output "rds_engine" {
  description = "RDS Engine"
  value       = aws_db_instance.tf-mysql-db-rds.engine
}

output "rds_port" {
  description = "RDS Port"
  value       = aws_db_instance.tf-mysql-db-rds.port
}

output "rds_publicly_accessible" {
  description = "RDS Publicly Accessible"
  value       = aws_db_instance.tf-mysql-db-rds.publicly_accessible
}
