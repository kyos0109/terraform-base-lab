# create dhcp option
resource "aws_vpc_dhcp_options" "ad_dopt" {
  domain_name         = var.domain_name
  domain_name_servers = var.domain_name_servers

  tags = merge({
    Name     = var.tag_name
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

# association to vpc
resource "aws_vpc_dhcp_options_association" "ad_dopt_association" {
  vpc_id          = var.vpc_id
  dhcp_options_id = aws_vpc_dhcp_options.ad_dopt.id
}