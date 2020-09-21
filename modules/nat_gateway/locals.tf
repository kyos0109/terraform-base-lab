locals {
  natgw_config = flatten([
    for natgw_key, natgw in var.nat_gateway_config : [
      {
        natgw_key      = natgw_key
        nat_tag_perfix = natgw.nat_tag_perfix
        nat_rtb_dst    = natgw.nat_rtb_dst
        eip_tag_perfix = natgw.eip_tag_perfix
        rtb_tag_perfix = natgw.rtb_tag_perfix
        zone           = natgw.zone
      }
    ]
  ])
}
