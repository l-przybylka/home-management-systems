resource "aws_lb_target_group" "lights" {
  name             = "app-target-group"
  port             = 3000
  protocol         = "HTTP"
  protocol_version = "HTTP1"
  vpc_id           = var.vpc_id

  health_check {
    matcher = 200
    path    = "/api/lights"
  }
}

resource "aws_lb_target_group_attachment" "lights" {
  target_group_arn = aws_lb_target_group.lights.arn
  target_id        = var.ec2_instances[2]
}

resource "aws_lb_listener_rule" "lights" {
  listener_arn = aws_lb_listener.app.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lights.arn
  }

  condition {
    path_pattern {
      values = ["/api/lights"]
    }
  }
}
