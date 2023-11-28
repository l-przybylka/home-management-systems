resource "aws_instance" "web" {
  count                       = length(pub_subnets)
  ami                         = "ami-0505148b3591e4c07"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  subnet_id                   = var.pub_subnets[count.index]
  vpc_security_group_ids      = var.security_group_id

  key_name = "my-vm-key-pair"
  tags = {
    Name = "app_server_00${count.index + 1}"
  }
}
