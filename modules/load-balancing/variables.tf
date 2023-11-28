variable "vpc_id" {
  type = string
}

variable "ec2_instances" {
  type = list(string)
}

variable "security_group_id" {
  type = list(string)
}

variable "pub_subnets" {
  type = list(string)
}
