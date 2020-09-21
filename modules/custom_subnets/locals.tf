locals {
  network_subnets = flatten([
    for network_key, network in var.subnets_config : [
      for subnet_key, subnet in network.subnets : {
        tag_perfix  = network.tag_perfix
        network_key = network_key
        subnet_key  = subnet_key
        cidr_block  = subnet.cidr_block
        zone        = subnet.zone
      }
    ]
  ])
}
