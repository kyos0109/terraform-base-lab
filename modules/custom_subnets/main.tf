# custom private subnet
resource "aws_subnet" "custom_subnet_zone" {
  for_each = {
    for subnet in local.network_subnets : "${subnet.network_key}.${subnet.subnet_key}" => subnet
  }

  vpc_id            = var.vpc_id
  availability_zone = element(var.availability_zone_names, var.availability_zone_map[each.value.zone])
  cidr_block        = each.value.cidr_block

  tags = merge({
      Name     = format("%s-%s-%s", var.project_prefix, each.value.tag_perfix, each.value.zone),
      AZ       = element(var.availability_zone_names, var.availability_zone_map[each.value.zone]),
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
