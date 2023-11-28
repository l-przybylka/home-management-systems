resource "aws_lb_target_group" "status" {
  name             = "app-target-group"
  port             = 3000
  protocol         = "HTTP"
  protocol_version = "HTTP1"
  vpc_id           = var.vpc_id

  health_check {
    matcher = 200
    path    = "/api/status/health"
  }
}

resource "aws_lb_target_group_attachment" "status" {
  target_group_arn = aws_lb_target_group.status.arn
  target_id        = var.ec2_instances[0]
}

resource "aws_lb_listener_rule" "status" {
  listener_arn = aws_lb_listener.app.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.status.arn
  }

  condition {
    path_pattern {
      values = ["/api/status"]
    }
  }
}
