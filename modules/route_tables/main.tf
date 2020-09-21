# create private subnet route default nat-gw
resource "aws_route_table" "custom_route_table" {
  for_each = {
    for rtb in local.rtb_config : rtb.natgw_key => rtb
  }

  vpc_id = var.vpc_id

  route {
    cidr_block = each.value.cidr_block
    gateway_id = element(aws_nat_gateway.nat_gw.*.id, count.index)
  }

  tags = merge({
    Name     = format("%s-%s-%s", var.project_prefix, each.value.tag_perfix),
    CreateAt = timestamp()
  },
    var.tags
  )

  lifecycle {
    ignore_changes = [
      tags["CreateAt"],
    ]
  }
}

# create private subnet route association
resource "aws_route_table_association" "private_route_association" {
  count          = length(module.private_subnets.ids)
  subnet_id      = element(module.private_subnets.this.*.id, count.index)
  route_table_id = element(aws_route_table.private_route_table.*.id, count.index)
}