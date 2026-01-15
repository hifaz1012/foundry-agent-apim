locals {
  apim_name = split("/", var.apim_resource_id)[8]
}

data "azurerm_api_management_subscription" "apim_master_subscription" {
  api_management_id = var.apim_resource_id
  subscription_id   = "master"
}

data "azapi_resource" "apim_api" {
  type        = "Microsoft.ApiManagement/service/apis@2025-03-01-preview"
  resource_id = "${var.apim_resource_id}/apis/${var.apim_api_name}"

  response_export_values = ["properties.path"]
}

resource "azapi_resource" "connection_apim" {
  name      = coalesce(var.connection_name, local.apim_name)
  parent_id = var.foundry_project_resource_id
  type      = "Microsoft.CognitiveServices/accounts/projects/connections@2025-10-01-preview"
  body = {
    properties = {
      category      = "ApiManagement"
      target        = "https://${local.apim_name}.azure-api.net/${data.azapi_resource.apim_api.output.properties.path}"
      authType      = "ApiKey"
      isSharedToAll = var.is_shared_to_all
      credentials = {
        key = data.azurerm_api_management_subscription.apim_master_subscription.primary_key
      }
      metadata = {
        deploymentInPath    = tostring(var.deployment_in_path)
        inferenceAPIVersion = var.inference_api_version
        models              = jsonencode(var.static_models)
      }
    }
  }
}
