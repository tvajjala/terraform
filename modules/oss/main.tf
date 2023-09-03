resource oci_objectstorage_bucket oss_bucket {
  access_type    = "NoPublicAccess"
  auto_tiering   = "Disabled"
  compartment_id = var.compartment_ocid


  freeform_tags = {
  }
  #kms_key_id = <<Optional value not found in discovery>>
  metadata = {

  }

  lifecycle {
    create_before_destroy = true
  }
  
  name                  = "terraform_oss"
  namespace             = var.objectns
  object_events_enabled = "false"
  storage_tier          = "Standard"
  versioning            = "Disabled"
}


output "bucket_ocid" {
  value = oci_objectstorage_bucket.oss_bucket.id
}