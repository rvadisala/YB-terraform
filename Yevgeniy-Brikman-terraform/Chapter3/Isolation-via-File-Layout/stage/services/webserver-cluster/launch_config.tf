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
  user_data = file("./install_apache.sh")
  lifecycle {
    create_before_destroy = true
  }
}
