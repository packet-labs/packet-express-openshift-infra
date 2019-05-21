OpenShift on Packet
==

A project to provision and bootstrap:

1. A master node pool
2. Worker node pools
3. Anycast IP Address for master node endpoint

to prepare infrastructure for [Openshift](https://www.openshift.com/).

Usage
---

This project requires a [Packet API](https://www.packet.com/developers/api/#) key, and Project ID. You can set these in `terraform.tfvars`:

```
auth_token = ""
project_id = ""
```

You will also need to set `ssh_private_key_path` (the path to the private key for the pair configured in your Packet Project), and then `terraform apply` to spin up this infrastructure. 

