remote_state {
  backend = "gcs"
  config = {
    bucket         = "terraform-cloud-run"
    prefix         = "${path_relative_to_include()}"
    credentials    = "./key.json"
  }
}

terraform {
  source = "${get_parent_terragrunt_dir()}/tenant-module"
}

inputs = merge(

  yamldecode(
    file("${get_terragrunt_dir()}/tenants.yaml")),
)