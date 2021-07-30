resource "aws_launch_configuration" "apache_web" {
  name_prefix                 = "web-apache-${var.env}"
  image_id                    = "ami-0ffc7af9c06de0077"
  instance_type               = var.instance_type
  key_name                    = "autoscale"
  security_groups             = [aws_security_group.web_ssh_allow.id]
  associate_public_ip_address = true
  root_block_device {
    delete_on_termination = true
    volume_size           = "8"
    volume_type           = "gp2"
  }
  user_data = data.template_file.user_data.rendered
  lifecycle {
    create_before_destroy = true
  }
  depends_on = [module.db_rds]
}

data "template_file" "user_data" {
  template   = file("${path.module}/user-data.sh")
  depends_on = [module.db_rds.rds_address]

  vars = {
    db_address    = module.db_rds.rds_address
    db_port       = module.db_rds.rds_port
    db_engine     = module.db_rds.rds_engine
    db_accessible = module.db_rds.rds_publicly_accessible
    #    db_address    = data.terraform_remote_state.db.db_address
  }
}

data "terraform_remote_state" "db" {
  backend = "local"

  config = {
    #    path = file("${path.cwd}/terraform.tfstate")
    path = "../../../stage/services/webserver-cluster/terraform.tfstate"
  }
  depends_on = [module.db_rds]
}



module "db_rds" {
  source     = "../../../modules/data/mysql"
  env        = var.env
  vpc-name   = var.vpc-name
  depends_on = [module.vpc]

}
