# output "ids" {
#   value = {
#     for natgw in aws_nat_gateway.nat_gw:
#       natgw.id => natgw.cidr_block
#     }
# }

output "natgw_eip" {
  value = {
    for natgw in aws_nat_gateway.nat_gw:
       natgw.id => natgw.public_ip
  }
}