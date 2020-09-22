output "this" {
  value = aws_subnet.custom_subnet_zone
}

output "subnet_info" {
  value = {
    for subnet in aws_subnet.custom_subnet_zone:
      format("%s[%s]",subnet.id, subnet.tags.Name) => subnet.cidr_block
  }
}
