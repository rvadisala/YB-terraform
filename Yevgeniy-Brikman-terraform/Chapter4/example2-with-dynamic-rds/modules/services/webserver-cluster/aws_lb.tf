resource "aws_lb" "web_lb" {
  name                             = var.cluster_name
  internal                         = false
  load_balancer_type               = "application"
  subnets                          = [module.vpc.public_subnets[0], module.vpc.public_subnets[1], module.vpc.public_subnets[2]]
  enable_deletion_protection       = false
  drop_invalid_header_fields       = true
  enable_cross_zone_load_balancing = true
  security_groups                  = [aws_security_group.alb_web.id]

}

resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = "404"
    }
  }
}

resource "aws_lb_listener_rule" "web_listener_rule" {
  listener_arn = aws_lb_listener.web_listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_target_group.arn
  }


  condition {
    path_pattern {
      values = ["*"]
    }
  }
}


resource "aws_lb_target_group" "web_target_group" {
  name     = var.cluster_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}




resource "aws_security_group" "alb_web" {

  name        = "web_alb_traffic"
  description = "Allow web traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
}
