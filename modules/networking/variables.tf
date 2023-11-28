variable "cidr" {
  type = string
}

variable "name" {
  type = string
}

variable "pub_subnets" {
  type = list(string)
}

variable "pri_subnets" {
  type = list(string)
}

variable "azs" {
  type = list(string)
}
