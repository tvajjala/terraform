terraform {
  required_version = ">= 1.0"
  required_providers {
    oci = {
      source  = "oracle/oci"
    }
  }
}



provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
	user_ocid        = var.user_ocid
	fingerprint      = var.fingerprint
	private_key_path = var.private_key_path
	region           = var.region
  #auth             = "SecurityToken"
  #config_file_profile = "BOAT_OC1"
   ignore_defined_tags = ["Oracle-Tags.CreatedBy", "Oracle-Tags.CreatedOn"]
}


provider "oci" {
  alias            = "home_region"
  tenancy_ocid     = var.tenancy_ocid
  region           = var.region
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
}

provider "oci" {
  alias            = "current_region"
  tenancy_ocid     = var.tenancy_ocid
  region           = var.region
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
}

data "oci_objectstorage_namespace" "osns" {
    #Optional
    compartment_id = var.compartment_ocid
}

output "oss_namespace" {
  value = data.oci_objectstorage_namespace.osns
}

## Modules

#
module "iam" {
	source            =   "./modules/iam"
  compartment_ocid  =   var.compartment_ocid
  providers = {
    oci = oci.home_region
  }
}


# Tag
module "defined-tags" {
	source            =   "./modules/tags"
  compartment_ocid  = var.compartment_ocid
  tenancy_ocid      = var.tenancy_ocid
  depends_on       = [module.iam]
  providers = {
    oci = oci.home_region
  }
}


# OSS
module "oss" {
	source            =   "./modules/oss"
  compartment_ocid  =   var.compartment_ocid
  objectns          =   "iduo0lxk0j9w" #data.oci_objectstorage_namespace.osns.namespace
  depends_on        =   [module.defined-tags]
}

#  VCN
module "vcn" {
	source            =  "./modules/vcn"
  compartment_ocid  =  var.compartment_ocid
   depends_on       =  [module.defined-tags]
}
