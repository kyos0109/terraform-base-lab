variable "vpc_id" {
  type        = string
  description = "vpc id"
}

variable "availability_zone_names" {
  type        = list(string)
  description = "availability zone"
  default     = []
}

variable "availability_zone_list" {
  type        = list
  description = "availability zone"
  default     = []
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

variable "tags" {
  type        = map
  description = "tags"
  default     = {}
}

variable "subnets_config" {
  type = list
}

variable "project_prefix" {
  type = string
}