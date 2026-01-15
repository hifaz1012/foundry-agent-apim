variable "subscription_id" {
  description = "The subscription ID to deploy resources into which is the same subscription as Foundry Project."
  type        = string
}

variable "apim_resource_id" {
  description = "The resource ID of the API Management service."
  type        = string
  validation {
    condition     = can(regex("^/subscriptions/[0-9a-fA-F-]+/resourceGroups/[a-zA-Z0-9-]+/providers/Microsoft.ApiManagement/service/[a-zA-Z0-9-]+$", var.apim_resource_id))
    error_message = "API Management ID must be a valid resource ID in the format: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ApiManagement/service/{serviceName}."
  }
}

variable "apim_api_name" {
  description = "The name of the API in API Management to connect to."
  type        = string
}

variable "connection_name" {
  description = "The name of the Foundry Project APIM connection. If not provided, defaults to the API Management service name."
  type        = string
  default     = ""
}

variable "deployment_in_path" {
  description = "Whether deployment name is in URL path vs body. Defaults to true which means deployment name is included in the URL path."
  type        = bool
  default     = true
}

variable "foundry_project_resource_id" {
  description = "The resource ID of the AI Foundry Project"
  type        = string

  validation {
    condition     = can(regex("^/subscriptions/[0-9a-fA-F-]+/resourceGroups/[a-zA-Z0-9-]+/providers/Microsoft.CognitiveServices/accounts/[a-zA-Z0-9-]+/projects/[a-zA-Z0-9-]+$", var.foundry_project_resource_id))
    error_message = "AI Foundry Project ID must be a valid resource ID in the format: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/projects/{projectName}."
  }
}

variable "inference_api_version" {
  description = "API version for inference calls (chat completions, embeddings). Defaults to '2025-03-01-preview'."
  type        = string
  default     = "2025-03-01-preview"
}

variable "is_shared_to_all" {
  description = "Share connection to all project users. Defaults to false."
  type        = bool
  default     = false
}

variable "static_models" {
  type = list(object({
    name = string
    properties = object({
      model = object({
        name    = string
        version = string
        format  = string
      })
    })
  }))
  default     = []
  description = <<DESCRIPTION
A list of static model deployments to be used in the connection. Each model deployment should include:
  - `name` - The name of the model deployment.
  - `properties` - Properties of the model.
    - `model` - Model details.
      - `name` - The name of the model.
      - `version` - The version of the model.
      - `format` - The format of the model.
DESCRIPTION
}