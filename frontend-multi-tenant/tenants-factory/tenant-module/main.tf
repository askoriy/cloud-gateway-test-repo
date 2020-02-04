resource "google_identity_platform_tenant" "tenant_tf" {
  for_each     = var.tenant_names
  display_name = each.key
  project      = var.project
  allow_password_signup = each.value.allow_password_signup
}

resource "google_identity_platform_tenant_default_supported_idp_config" "idp_config_google" {
  for_each = {
        for key, value in var.tenant_names:
        key => key
        if value.create_idp_resource_google
  }
  enabled       = true
  project       = var.project
  tenant        =  tomap(google_identity_platform_tenant.tenant_tf)[each.key].name
  idp_id        = "google.com"
  client_id     = var.tenant_names[each.value].idp_resource_google_config.app_id
  client_secret = var.tenant_names[each.value].idp_resource_google_config.secret
}

resource "google_identity_platform_tenant_default_supported_idp_config" "idp_config_microsoft" {
  for_each = {
        for key, value in var.tenant_names:
        key => key
        if value.create_idp_resource_microsoft
  }
  enabled       = true
  project       = var.project
  tenant        =  tomap(google_identity_platform_tenant.tenant_tf)[each.key].name
  idp_id        = "microsoft.com"
  client_id     = var.tenant_names[each.value].idp_resource_microsoft_config.app_id
  client_secret = var.tenant_names[each.value].idp_resource_microsoft_config.secret
}

output "tenant_names" {
  value = values(google_identity_platform_tenant.tenant_tf)[*]["display_name"]
}

resource "local_file" "tenants_list" {
  content = <<EOF
%{ for k,v in google_identity_platform_tenant.tenant_tf}
${k}:
  tenant_id: ${v.name}
  idps: 
    %{~ if var.tenant_names[k].allow_password_signup ~}
    - email
    %{~ endif ~}
     %{~ if var.tenant_names[k].create_idp_resource_google ~}
    - google
    %{~ endif ~}
    %{~ if var.tenant_names[k].create_idp_resource_microsoft ~}
    - microsoft
    %{~ endif ~}
%{~ endfor ~}
   EOF
   filename = "../../../tenants_list_front.yaml"
}