output "subnet_array" {
  value = zipmap(
    aws_subnet.public_subnet_zone.*.id, aws_subnet.public_subnet_zone.*.cidr_block
  )
}

output "this" {
  value = aws_subnet.public_subnet_zone
}

output "ids" {
  value = aws_subnet.public_subnet_zone.*.id
}

output "short_zone_name" {
  value = {
    for subnet_key, subnet in aws_subnet.public_subnet_zone:
      element(var.availability_zone_list.*.name_suffix, subnet_key) => subnet.id
  }
}

output "subnet_info" {
  value = {
    for subnet in aws_subnet.public_subnet_zone:
      format("%s[%s]",subnet.id, subnet.tags.Name) => subnet.cidr_block
  }
}