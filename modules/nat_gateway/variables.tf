variable "vpc_id" {
  type = string
}

variable "nat_gateway_config" {
  type = list
}

variable "tags" {
  type        = map
  description = "tags"
  default     = {}
}

variable "availability_zone_names" {
  type        = list(string)
  description = "availability zone"
  default     = []
}

variable "project_prefix" {
  type = string
}

variable "depends" {
  type = list
}

variable "short_zone_name" {
  type = map
}

variable "availability_zone_map" {
    type = map(string)

    default = {
        a = "0"
        b = "1"
        c = "2"
        d = "3"
        e = "4"
        f = "5"
    }
}