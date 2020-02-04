remote_state {
  backend = "gcs"
  config = {
    bucket   = "terraform-tenant-bucket"
    prefix   = "${path_relative_to_include()}"
  }
}

terraform {
  source = "${get_parent_terragrunt_dir()}/tenant-module"
}

inputs = merge(

  yamldecode(
    file("${get_terragrunt_dir()}/tenants.yaml")),
)