
variable "tenancy_ocid" {
  default    = "ocid1.tenancy.oc1..aaaaaaaanhpvoliwncislsdvgelckdq6lsj6x3wgmcugorkgdpwdibcb22na"
}

variable "user_ocid" {
  default    = "ocid1.user.oc1..aaaaaaaaauugged4aryfcfa2aqq7eelmq2xjfpuotlxgpradqg4bujnxb2ga"
}

variable "fingerprint" {
  default    = "d8:52:e1:53:d0:69:ff:f7:5a:6c:b2:ab:eb:84:77:09"
}

variable "region" {
  default     = "us-ashburn-1"
  description = "region where you have OCI tenancy"
  type        = string
}

variable "private_key_path" {
  default     = "~/.oci/sfcp_api_key.pem"
}

variable "ssh_public_key" {
  default     = "~/.oci/sfcp_api_key_public.pem"
}



variable "compartment_ocid" {
  description = "devops compartment ocid"
  type = string
}
