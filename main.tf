locals {
  project = "main-105"
  region  = "us-central1"
}

provider "google-beta" {
  version     = "~> 3.5"
  project     = local.project
  region      = local.region 
  credentials = "key.json"
}

resource "google_identity_platform_tenant" "tenant1" {
  provider     = google-beta
  display_name = "Tenant-1"
  project      = local.project     
}