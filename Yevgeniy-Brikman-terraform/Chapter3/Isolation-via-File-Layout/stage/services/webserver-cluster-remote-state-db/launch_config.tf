resource "aws_launch_configuration" "apache_web" {
  name_prefix                 = "web-apache-"
  image_id                    = "ami-0ffc7af9c06de0077"
  instance_type               = "t2.micro"
  key_name                    = "autoscale"
  security_groups             = [aws_security_group.web_ssh_allow.id]
  associate_public_ip_address = true
  root_block_device {
    delete_on_termination = true
    volume_size           = "8"
    volume_type           = "gp2"
  }
  user_data       = data.template_file.user_data.rendered
  lifecycle {
    create_before_destroy = true
  }
}


data "template_file" "user_data" {
  template = file("user-data.sh")

  vars = {
    db_address  = data.terraform_remote_state.db.outputs.rds_address
    db_port     = data.terraform_remote_state.db.outputs.rds_port
    db_engine   = data.terraform_remote_state.db.outputs.rds_engine
    db_accessible = data.terraform_remote_state.db.outputs.rds_publicly_accessible
  }
}


data "terraform_remote_state" "db" {
  backend = "s3"

  config = {
    bucket = "ne-terraform-state-backup"
    key    = "stage/data-stores/mysql/terraform.tfstate"
    region = "ap-south-1"
  }
}
