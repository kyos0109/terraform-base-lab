variable "vpc_id" {
    type = string
}

variable "domain_name_servers" {
    type = list
}

variable "domain_name" {
    type = string
}

variable "tags" {
  type        = map
  description = "tags"
  default     = {}
}

variable "tag_name" {
  type        = string
}
