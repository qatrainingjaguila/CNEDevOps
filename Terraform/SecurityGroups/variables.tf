variable "ingress_ports" {
  type        = list(number)
  description = "List of ingress ports"
  default     = [22,80,443,3306,8080]
}

variable "vpc_id" {

}

variable "name" {
    
}

variable "outbound-port" {
  default = 0
}

variable "open-internet" {
  type = list
  default = ["0.0.0.0/0"]
}