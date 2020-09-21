variable "subnet_newbits" {
  type    = number
  default = 8
}

variable "vpc_config" {
  type = map(string)
  description = "vpn config"

  default = {
    default_cidr_block = "10.123.0.0/16"
    tag_name           = "vpc"
    igw_tag_name       = "igw"
  }
}

variable "project_config" {
  type = map(string)
  description = "project config"

  default = {
    tag_perfix = "demo"
  }
}

variable "dopt_config" {
  type = map(string)
  description = "dhcp option config"

  default = {
    dns1     = "8.8.8.8"
    dns2     = "1.1.1.1"
    tag_name = "dopt"
    domain   = "rb.int"
  }
}

variable "resource_tags" {
  type        = map(string)
  description = "resource tags"

  default = {
    Project = "demo"
    Creator = "tf"
  }
}

variable "public_subnet_config" {
  type        = map(string)
  description = "public subnet config"

  default = {
    perfix_name = "public"
  }
}

variable "subnet_config" {
  type = list(object({
    tag_perfix = string
    subnets    = list(object({
      cidr_block = string
      zone       = string
      }))
  }))

  default = [
    {
      tag_perfix = "game-nginx"
      subnets    = [
        {
          cidr_block = "10.123.99.0/24"
          zone       = "a"
        },
        {
          cidr_block = "10.123.98.0/24"
          zone       = "c"
        }
      ]
    },
    {
      tag_perfix = "game-web"
      subnets    = [
        {
          cidr_block = "10.123.100.0/24"
          zone       = "c"
        },
        {
          cidr_block = "10.123.101.0/24"
          zone       = "b"
        }
      ]
    },
    {
      tag_perfix = "game-api"
      subnets    = [
        {
          cidr_block = "10.123.20.0/24"
          zone       = "c"
        },
        {
          cidr_block = "10.123.21.0/24"
          zone       = "c"
        },
        {
          cidr_block = "10.123.22.0/24"
          zone       = "c"
        }
      ]
    },
    {
      tag_perfix = "game-db"
      subnets    = [
        {
          cidr_block = "10.123.200.0/24"
          zone       = "a"
        },
        {
          cidr_block = "10.123.201.0/24"
          zone       = "b"
        },
        {
          cidr_block = "10.123.202.0/24"
          zone       = "c"
        }
      ]
    }
  ]
}

variable "nat_gateway_config" {
  type = list(object({
    eip_tag_perfix = string
    nat_tag_perfix = string
    rtb_tag_perfix = string
    nat_rtb_dst    = string
    zone           = string
  }))

  description = "nat gateway config"

  default = [
    {
      eip_tag_perfix = "game-natgw-eip"
      rtb_tag_perfix = "game-rtb"
      nat_tag_perfix = "game-natgw"
      zone           = "a"
      nat_rtb_dst    = "0.0.0.0/0"
    },
    {
      eip_tag_perfix = "game-natgw-eip"
      rtb_tag_perfix = "game-rtb"
      nat_tag_perfix = "game-natgw"
      zone           = "c"
      nat_rtb_dst    = "0.0.0.0/0"
    },
  ]
}
