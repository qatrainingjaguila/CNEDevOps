variable "vpc-cidr-block" {
    default = "10.0.0.0/16"
}

variable "pub-snA-cidr-block" {
  description = "CIDR block for Public Subnet A"
  default     = "10.0.1.0/24"
}

variable "pub-snB-cidr-block" {
  description = "CIDR block for Public Subnet B"
  default     = "10.0.2.0/24"
}

variable "pub-snC-cidr-block" {
  description = "CIDR block for Public Subnet C"
  default     = "10.0.3.0/24"
}