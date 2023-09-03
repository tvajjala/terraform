## Policy:  Allow group GroupA to inspect tag-namespaces in compartment A:B:C
## Create Defined Tag  Department Under namespace : Codergists
## Codergists.Department ["Managers", "Developers","Architects"]

terraform {
  required_version = ">= 1.0"
  required_providers {
    oci = {
      source  = "oracle/oci"
    }
  }
}

resource "random_id" "tag" {
  byte_length = 2
}

## Namespace Creation
resource "oci_identity_tag_namespace" "Codergists" {
  provider       = oci
  compartment_id = var.compartment_ocid
  description    = "Codergists"
  name           = "Codergists"
  is_retired = false
  provisioner "local-exec" {
    command = "sleep 10"
  }
}

## Defined Tag
resource "oci_identity_tag" "Department" {
  provider         = oci
  description      = "Department"
  name             = "department"
  tag_namespace_id = oci_identity_tag_namespace.Codergists.id

  validator {
    validator_type = "ENUM"
    values         = ["Managers", "Developers","Architects"]
  }

  provisioner "local-exec" {
    command = "sleep 120"
  }
}

## oci_identity_tag_namespaces only works for tenancy_OCID
##  400-NotImplemented, Only implemented for Tenancies right now
data "oci_identity_tag_namespaces" "CoderTags" {
    #Required
    compartment_id = var.tenancy_ocid

    #Optional
    include_subcompartments = true
    state = "ACTIVE"
}

# Output the result
output "show-tag-ns" {
  value = data.oci_identity_tag_namespaces.CoderTags.tag_namespaces
}
