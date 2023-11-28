module "vpc" {
  source = "./modules/networking"

  name        = "home-management"
  cidr        = "10.0.0.0/20"
  azs         = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  pub_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  pri_subnets = ["10.0.8.0/24", "10.0.9.0/24", "10.0.10.0/24"]

}

module "security" {
  source = "./modules/security"

  vpc_id = module.vpc.vpc_id
}

module "app_server" {
  source = "./modules/app-server"

  pub_subnets       = module.vpc.pub_subnets_ids
  security_group_id = module.security.security_group_id
}

module "load-balaning" {
  source = "./modules/load-balancing"

  vpc_id            = module.vpc.vpc_id
  pub_subnets       = module.vpc.pub_subnets_ids
  security_group_id = module.security.security_group_id
  ec2_instances     = module.app_server.ec2_instances_ids
}
