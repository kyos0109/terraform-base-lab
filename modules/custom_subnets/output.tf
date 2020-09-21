output "subnet_array" {
  value = {
    for subnet in aws_subnet.custom_subnet_zone:
      subnet.id => subnet.cidr_block
  }
}

output "this" {
  value = aws_subnet.custom_subnet_zone
}

output "ids" {
  value = {
    for key, subnet in aws_subnet.custom_subnet_zone:
      key => subnet.id
  }
}