# get available zone
data "aws_availability_zones" "available" {}

# available zone convert to array index mode
data "aws_availability_zone" "all_zone_array" {
  count = length(data.aws_availability_zones.available.names)
  name  = local.zone_ids_list[count.index]
}