output "natgw_eip" {
  value = {
    for natgw in aws_nat_gateway.nat_gw:
       format("%s[%s]",natgw.id, natgw.tags.Name) => natgw.public_ip
  }
}

output "this_rtb" {
  value = aws_route_table.custom_route_table
}

output "route_map" {
  value = {
    for rtb in aws_route_table.custom_route_table:
      rtb.tags.AZ => rtb.id
  }
}