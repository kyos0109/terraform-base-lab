# create custom subnet route association
resource "aws_route_table_association" "custom_route_association" {
  for_each = var.subnets

  subnet_id      = each.value.id
  route_table_id = lookup(var.route_tables, each.value.tags.AZ, var.subnet_not_match_rtb_zone_default)
}