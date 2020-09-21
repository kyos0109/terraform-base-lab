locals {
  rtb_config = flatten([
    for rtb_key, rtb in var.route_table_config : [
      {
        natgw_key      = natgw_key
        tag_perfix     = natgw.tag_perfix
        cidr_block     = natgw.cidr_block
      }
    ]
  ])
}
