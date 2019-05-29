variable "pool_label" {}
variable "count_x86" {}
variable "count_arm" {}
variable "plan_x86" {}
variable "plan_arm" {}
variable "facility" {}
variable "cluster_name" {}
variable "project_id" {}

resource "packet_device" "x86_node" {
  hostname         = "${format("${var.cluster_name}-x86-${var.pool_label}-%02d", count.index)}"
  operating_system = "rhel_7"
  count            = "${var.count_x86}"
  plan             = "${var.plan_x86}"
  facilities       = ["${var.facility}"]
  tags             = ["kubernetes", "openshift", "pool-${var.cluster_name}-${var.pool_label}-x86"]

  billing_cycle = "hourly"
  project_id    = "${var.project_id}"
}

resource "packet_device" "arm_node" {
  hostname         = "${format("${var.cluster_name}-arm-${var.pool_label}-%02d", count.index)}"
  operating_system = "rhel_7"
  count            = "${var.count_arm}"
  plan             = "${var.plan_arm}"
  facilities       = ["${var.facility}"]
  tags             = ["kubernetes", "openshift", "pool-${var.cluster_name}-${var.pool_label}-arm"]

  billing_cycle = "hourly"
  project_id    = "${var.project_id}"
}
