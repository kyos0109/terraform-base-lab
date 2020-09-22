output "public_subnet" {
  value = module.public_subnets.subnet_info
}

output "custom_subnet" {
  value = module.subnets.subnet_info
}

output "nat_gateway_eip" {
  value = module.nat_gw.natgw_eip
}

# output "jumper_public_ip" {
#   value = zipmap(
#     module.jumper_eip.this.*.tags.Name,
#     module.jumper_eip.this.*.public_ip
#   )
# }

# output "load_balancer_info" {
#   value = module.demo_alb.lb_info
# }
