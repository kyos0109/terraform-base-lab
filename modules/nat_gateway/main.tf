# Create NAT Gateway EIP
resource "aws_eip" "eips" {
  for_each = {
    for natgw in local.natgw_config : natgw.natgw_key => natgw
  }

  depends_on = [var.depends]
  vpc        = true

  tags = merge({
    Name     = format("%s-%s-%s", var.project_prefix, each.value.eip_tag_perfix, each.value.zone),
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

# Create NAT Gateway
resource "aws_nat_gateway" "nat_gw" {
  for_each = {
    for natgw in local.natgw_config : natgw.natgw_key => natgw
  }
  
  depends_on    = [var.depends]
  allocation_id = aws_eip.eips[each.key].id
  subnet_id     = var.short_zone_name[each.value.zone]

  tags = merge({
    Name     = format("%s-%s-%s", var.project_prefix, each.value.nat_tag_perfix, each.value.zone),
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

# create custom subnet route default nat-gw
resource "aws_route_table" "custom_route_table" {
  for_each = {
    for natgw in local.natgw_config : natgw.natgw_key => natgw
  }

  vpc_id = var.vpc_id

  route {
    cidr_block = each.value.nat_rtb_dst
    gateway_id = aws_nat_gateway.nat_gw[each.key].id
  }

  tags = merge({
    Name     = format("%s-%s-%s", var.project_prefix, each.value.rtb_tag_perfix, each.value.zone),
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
