locals {
  project = "gcp-examples-staging-c693"
  region  = "europe-west1"
}

resource "google_identity_platform_tenant" "tenant1" {
  provider     = google-beta
  display_name = "Tenant-1"
  project      = local.project   
  credentials  =  "key.json"
}