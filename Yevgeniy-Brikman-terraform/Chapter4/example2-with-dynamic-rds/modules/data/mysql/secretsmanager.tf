resource "aws_secretsmanager_secret" "rds_secret" {
  name        = "tf-mysql-rds-passwd-${var.env}"
  description = "Mysql RDS Admin password"
  tags = {
    Name = "RDS Password"
  }
}


resource "aws_secretsmanager_secret_version" "rds_secret_val" {
  secret_id     = aws_secretsmanager_secret.rds_secret.id
  secret_string = "MysqlAdminPassword-${var.env}"
}
