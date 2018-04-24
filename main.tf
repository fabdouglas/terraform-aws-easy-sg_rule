locals {
  ingress = "${keys(var.ingress)}"
}

resource "aws_security_group_rule" "ingress" {
  type              = "ingress"
  count             = "${length(local.ingress)}"
  from_port         = "${element(split("-", element(split("/",element(split(" ", lookup(var.ingress, element(local.ingress, count.index))), 1)), 0)), 0)}"
  to_port           = "${element(split("-", element(split("/",element(split(" ", lookup(var.ingress, element(local.ingress, count.index))), 1)), 0)), 1)}"
  protocol          = "${element(split(" ", lookup(var.ingress, element(local.ingress, count.index))), 2)}"
  cidr_blocks       = ["${split(",",element(split(" ", lookup(var.ingress, element(local.ingress, count.index))), 0))}"]
  description       = "${element(local.ingress, count.index)}"
  security_group_id = "${var.security_group}"
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${var.security_group}"
}
