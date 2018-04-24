variable "security_group" {}

variable "ingress" {
  default = {} # Ex. {"Terraform" = "0.0.0.0/0,::/0 22-443 tcp"}
}
