# grep --after-context=10 outputs terraform.tfstate
# terraform output -json
# curl $(terraform output -raw lb_url)
# terraform output -raw lb_url

###############################################################################################################
#resource "aws_subnet" "rds" {
#  count                   = "${length(data.aws_availability_zones.available.names)}"
#  vpc_id                  = "${aws_vpc.vpc.id}"
#  cidr_block              = "10.0.${length(data.aws_availability_zones.available.names) + count.index}.0/24"
#  map_public_ip_on_launch = true
#  availability_zone       = "${element(data.aws_availability_zones.available.names, count.index)}"
#  tags {
#    Name = "rds-${element(data.aws_availability_zones.available.names, count.index)}"
#  }
# }

#data "aws_subnet" "dmzSubnet0" {
#  vpc_id = "${data.aws_vpc.targetVpc.id}"
#  filter {
#    name = "tag:Name"
#    values = ["${data.aws_vpc.targetVpc.tags.Name}.dmz0"]
#  }
#}
###############################################################################################################


data "aws_vpc" "custom" {
  filter {
    name   = "tag:Name"
    values = [var.vpc-name]
  }
}

data "aws_subnet" "aws_db_subnet" {
  vpc_id = data.aws_vpc.custom.id
  filter {
    name   = "tag:Name"
    values = ["${var.vpc-name}-db-ap-south-1a"]
  }
}

resource "aws_security_group" "db_security" {

  vpc_id      = data.aws_vpc.custom.id
  description = "rds security group"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 3306
    protocol    = "tcp"
    to_port     = 3306
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

}

resource "aws_db_instance" "tf-mysql-db-rds" {
  engine              = "mysql"
  engine_version      = "8.0.23"
  identifier_prefix   = "tf-mysql-db-rds"
  password            = aws_secretsmanager_secret_version.rds_secret_val.secret_string
  instance_class      = "db.t2.micro"
  allocated_storage   = "10"
  port                = "3306"
  publicly_accessible = false
  storage_type        = "gp2"
  username            = "admin"
  # db_subnet_group_name   =  data.aws_vpc.custom.name
  db_subnet_group_name   = data.aws_vpc.custom.tags.Name
  vpc_security_group_ids = [aws_security_group.db_security.id]
  skip_final_snapshot    = true
  tags = {
    Name = "Mysql_RDS_Terraform"
  }
}
