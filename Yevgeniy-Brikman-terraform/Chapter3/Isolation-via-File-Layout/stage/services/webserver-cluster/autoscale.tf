resource "aws_autoscaling_group" "web_asg" {
  name                  = "asg-webserver"
  launch_configuration  = aws_launch_configuration.apache_web.id
  capacity_rebalance    = true
  default_cooldown      = "300"
  desired_capacity      = "2"
  force_delete          = true
  max_instance_lifetime = 0
  max_size              = 2
  min_size              = 2
  vpc_zone_identifier   = [module.vpc.public_subnets[0], module.vpc.public_subnets[1], module.vpc.public_subnets[2]]
  target_group_arns     = [aws_lb_target_group.web_target_group.arn]
  health_check_type     = "ELB"
  tag {
    key                 = "Name"
    value               = "webserver_autoscale"
    propagate_at_launch = true
  }
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }
}
