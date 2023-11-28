resource "aws_lb_target_group" "app_target_group" {
  name             = "app-target-group"
  port             = 3000
  protocol         = "HTTP"
  protocol_version = "HTTP1"
  vpc_id           = var.vpc_id

  health_check {
    matcher = 200
    path    = "/health-check"
  }
}

resource "aws_lb_target_group_attachment" "app_tg_attachment" {
  count            = length(var.ec2_instances)
  target_group_arn = aws_lb_target_group.app_target_group.arn
  target_id        = var.ec2_instances[count.index]
}


resource "aws_lb" "app_lb" {
  name               = "app-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_group_id
  subnets            = var.pub_subnets
}

resource "aws_lb_listener" "app_lb_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_target_group.arn
  }
}
