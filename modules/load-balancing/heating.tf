resource "aws_lb_target_group" "heating" {
  name             = "heating-target-group"
  port             = 3000
  protocol         = "HTTP"
  protocol_version = "HTTP1"
  vpc_id           = var.vpc_id

  health_check {
    matcher = 200
    path    = "/api/heating/health-check"
  }
}

resource "aws_lb_target_group_attachment" "heating" {
  target_group_arn = aws_lb_target_group.heating.arn
  target_id        = var.ec2_instances[1]
}

resource "aws_lb_listener_rule" "heating" {
  listener_arn = aws_lb_listener.app.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.heating.arn
  }

  condition {
    path_pattern {
      values = ["/api/heating"]
    }
  }
}
