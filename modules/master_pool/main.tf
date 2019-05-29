variable "count" {}
variable "plan_primary" {}
variable "facility" {}
variable "cluster_name" {}
variable "ssh_private_key_path" {}
variable "anycast_ip" {}
variable "project_id" {}

data "template_file" "controller" {
  template = "${file("${path.module}/controller.tpl")}"

  vars {
    anycast_ip = "${var.anycast_ip}"
  }
}

resource "packet_device" "openshift_primary" {
  hostname         = "${format("packet-openshift-${var.cluster_name}-${var.facility}-controller--%02d", count.index)}"
  operating_system = "rhel_7"
  plan             = "${var.plan_primary}"
  facilities       = ["${var.facility}"]
  user_data        = "${data.template_file.controller.rendered}"
  count            = "${var.count}"

  provisioner "local-exec" {
    command = "scp -i ${var.ssh_private_key_path} -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null scripts/create_bird_conf.sh root@${self.access_public_ipv4}:/root/create_bird_conf.sh"
  }

  billing_cycle = "hourly"
  project_id    = "${var.project_id}"
}

resource "packet_bgp_session" "openshift-controllers" {
  count          = "${var.count}"
  device_id      = "${packet_device.openshift_primary.*.id[count.index]}"
  address_family = "ipv4"
}
