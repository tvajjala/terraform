resource "oci_core_vcn" "terraform-vcn" {
  #dns_label      = "vcn"
  cidr_block     = "172.16.0.0/16"
  compartment_id = var.compartment_ocid
  display_name   = "Terraform_VCN"
  
  #defined_tags   = { "${oci_identity_tag_namespace.Codergists.name}.${oci_identity_tag.Department.name}" = "Architects"}
  

}


resource "oci_core_subnet" "private_subnet" {
  vcn_id                      = oci_core_vcn.terraform-vcn.id
  cidr_block                  = "172.16.0.0/24"
  compartment_id              = var.compartment_ocid
  display_name                = "Public_Subnet"
  prohibit_public_ip_on_vnic  = true
  #dns_label                   = "privatesubnet"
 # defined_tags   = { "${oci_identity_tag_namespace.Codergists.name}.${oci_identity_tag.Department.name}" = "Architects" }
}
