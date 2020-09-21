variable "name" {
  type = string
}

variable "description" {
  type        = string
  description = "describe"
}

variable "tags" {
  type        = map
  default     = {}
}