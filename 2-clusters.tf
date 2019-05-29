resource "packet_reserved_ip_block" "anycast_ip" {
  project_id = "${var.project_id}"
  type       = "global_ipv4"
  quantity   = 1
  facility   = ""
}

module "masters_openshift" {
  source = "./modules/master_pool"

  cluster_name         = "openshift"
  count                = "${var.count}"
  plan_primary         = "${var.plan_primary}"
  facility             = "${var.facility}"
  ssh_private_key_path = "${var.ssh_private_key_path}"
  project_id           = "${var.project_id}"
  anycast_ip           = "${packet_reserved_ip_block.anycast_ip.address}"
}

module "node_pool_blue" {
  source = "modules/node_pool"

  pool_label         = "openshift-blue"
  count_x86          = "${var.count_x86}"
  count_arm          = "${var.count_arm}"
  plan_x86           = "${var.plan_x86}"
  plan_arm           = "${var.plan_arm}"
  facility           = "${var.facility}"
  cluster_name       = "${var.cluster_name}"
  project_id         = "${var.project_id}"
}
