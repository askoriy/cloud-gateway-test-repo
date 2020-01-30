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
  for_each     = var.tenant_names
  display_name = each.value
  project      = local.project     
}

output "tenant_name" {
  value = google_identity_platform_tenant.tenant_tf[*]
}
