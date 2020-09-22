provider "aws" {
    profile = "demo"
    region = "ap-east-1"
}

# get availability zones info
module "availability_zones" {
  source = "./modules/availability_zones"
}

# create vpc
module "vpc" {
  source       = "./modules/vpc"
  cidr_block   = var.vpc_config.default_cidr_block
  tags         = var.resource_tags
  tag_name     = format("%s-%s", var.project_config.tag_perfix, var.vpc_config.tag_name)
  igw_tag_name = format("%s-%s", var.project_config.tag_perfix, var.vpc_config.igw_tag_name)
}

# create dhcp option
module "dhcp_options" {
  source              = "./modules/dhcp_options"
  vpc_id              = module.vpc.this.id
  domain_name         = var.dopt_config.domain
  domain_name_servers = [var.dopt_config.dns1, var.dopt_config.dns2]
  tag_name            = format("%s-%s", var.project_config.tag_perfix, var.dopt_config.tag_name)
  tags                = var.resource_tags
}

# create public subnets
module "public_subnets" {
  source                  = "./modules/public_subnets"
  vpc_id                  = module.vpc.this.id
  cidr_block_default      = module.vpc.this.cidr_block
  availability_zone_names = module.availability_zones.names
  availability_zone_list  = module.availability_zones.list
  subnet_newbits          = var.subnet_newbits
  tag_name                = format("%s-%s", var.project_config.tag_perfix, var.public_subnet_config.perfix_name)
  tags                    = var.resource_tags
}

# create iam policy
module "ec2_SSM" {
  source = "./modules/iam_role"

  name        = "EC2DomainJoin"
  description = "EC2DomainJoin"
  tags        = var.resource_tags
}

# create subnet
module "subnets" {
  source                  = "./modules/custom_subnets"
  vpc_id                  = module.vpc.this.id
  availability_zone_names = module.availability_zones.names
  subnets_config          = var.subnet_config
  project_prefix          = var.project_config.tag_perfix
  tags                    = var.resource_tags
}

# create nat gateway
module "nat_gw" {
  source                  = "./modules/nat_gateway"
  vpc_id                  = module.vpc.this.id
  availability_zone_names = module.availability_zones.names
  depends                 = [module.vpc.igw]
  short_zone_name         = module.public_subnets.short_zone_name
  project_prefix          = var.project_config.tag_perfix
  nat_gateway_config      = var.nat_gateway_config
  tags                    = var.resource_tags
}

# create subnet route association
module "subnet_route_association" {
  source       = "./modules/route_tables_asso"
  route_tables = module.nat_gw.route_map
  subnets      = module.subnets.this

  subnet_not_match_rtb_zone_default = module.nat_gw.this_rtb[0].id
}
