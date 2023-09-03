terraform {
  required_version = ">= 1.0"
  required_providers {
    oci = {
      source  = "oracle/oci"
    }
  }
}

resource "oci_identity_policy" "codergists_policy" {
  provider       = oci # can be any name it should match line #4 and main.tf line #58
  name           = "codergists_policy"
  description    = "policy created for codergists"
  compartment_id = var.compartment_ocid
  statements = [
    "Allow group codergists to manage tag-namespaces in compartment id ${var.compartment_ocid}",
    "Allow group codergists to manage object-family in compartment  id ${var.compartment_ocid}",
    "Allow group codergists to manage virtual-network-family in compartment id ${var.compartment_ocid}"
  ]
  # wait 1o seconds before proceeding to other oci resource creation
  provisioner "local-exec" {
    command = "sleep 10"
  }
}