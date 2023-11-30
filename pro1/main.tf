
module "vpc" {
  source               = "./vpc_module"
  environment          = "EKS-Cluster"
  vpc_cidr             = "192.168.0.0/16"
  public_subnets_cidr  = ["192.168.1.0/24", "192.168.2.0/24"]
  private_subnets_cidr = ["192.168.3.0/24", "192.168.4.0/24"]
  availability_zones   = ["ap-southeast-1a", "ap-southeast-1b"]
}


module "vpc1" {
  source               = "./vpc"
  environment1          = "EKS-Cluster1"
  vpc1_cidr             = "172.168.0.0/16"
  public_subnets_cidr1  = ["172.168.1.0/24", "172.168.2.0/24"]
  private_subnets_cidr1 = ["172.168.3.0/24", "172.168.4.0/24"]
  availability_zones1   = ["eu-west-1a", "eu-west-1b"] 
}


module "perring" {
  source ="./perr"
  depends_on = [ module.vpc , module.vpc1 ]
  requester_vpc_id =module.vpc.vpc-id
  requester_region ="ap-southeast-1"
  vpc_cidr_req =  module.vpc.vpc_cidr
  route_table_req = module.vpc.route_table_req

  accpeter_vpc_id = module.vpc1.vpc1-id
  accepter_region = "eu-west-1"
  vpc_cidr_acc = module.vpc1.vpc1_cidr
  route_table_acc = module.vpc1.route_table_acc

}

