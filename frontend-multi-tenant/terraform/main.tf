terraform {
  backend "gcs" {
    bucket   = "terraform-cloud-run"
    prefix   = "state"
  }
}

locals {
  project = "main-105"
  region  = "us-central1"
}

provider "google-beta" {
  version     = "~> 3.5"
  project     = local.project
  region      = local.region 
}

resource "google_identity_platform_tenant" "tenant_tf" {
  provider     = google-beta
  display_name = "Tenant-terraform"
  project      = local.project     
}

resource "google_identity_platform_tenant" "tenant_tf_2" {
  provider     = google-beta
  display_name = "Tenant-terraform-2"
  project      = local.project     
}

output "tenant_name" {
  value = google_identity_platform_tenant.tenant_tf.name
}

output "tenant_name_2" {
  value = google_identity_platform_tenant.tenant_tf_2.name
}
