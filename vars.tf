variable "auth_token" {
  description = "Your Packet API key"
}

variable "project_id" {
  description = "Your Packet Project ID"
}

variable "ssh_private_key_path" {
  description = "Your SSH private key path (used locally only)"
}

variable "facility" {
  description = "Your primary facility"
  default     = "nrt1"
}

variable "plan_primary" {
  description = "Plan for Master Nodes"
  default     = "baremetal_0"
}

variable "plan_arm" {
  description = "Plan for ARM Nodes"
  default     = "baremetal_2a"
}

variable "plan_x86" {
  description = "Plan for x86 Nodes"
  default     = "baremetal_0"
}

variable "count" {
  default     = "1"
  description = "Number of Master Nodes."
}

variable "count_x86" {
  default = "1"
  description = "Number of x86 Nodes"
}

variable "count_arm" {
  default = "1"
  description = "Number of ARM Nodes"
}

variable "cluster_name" {
  default = "packet-openshift"
  description = "Cluster name label"
}