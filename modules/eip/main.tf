# create NAT Gateway
resource "aws_eip" "eips" {
  for_each   = var.eip_config
  vpc        = true
  depends_on = var.depends

  tags = merge({
    Name     = format("%s-%s", var.project_prefix, each.value.tag_perfix),
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