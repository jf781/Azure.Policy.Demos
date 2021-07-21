variable "rgName" {
    type = string
    default = "JF-AzPolicy-Demo"
    description = "Name of the resource group.  Used for scoping policy assignment"
}

variable "policyAssignment" {
  type = list(any)
  description = "Details for the policy assignment"
  default = [
    {
      policyAsgnName            = "Sample Policy Assignment 1"
      policyAsgnDescription     = "Sample Policy Assignment Description 1"
      policyDefName             = "Sample Policy definition 1"
      policyAsgnParameters       = <<PARAMS
        {
          "tagName":{
              "value": "Environment"
          },
          "tagValue1":{
              "value": "Prod"
          },
          "tagValue2":{
              "value": "Dev"
          },
          "tagValue3":{
              "value": "QA"
          }
        }
      PARAMS
    },
    {
      policyAsgnName            = "Sample Policy Assignment 2"
      policyAsgnDescription     = "Sample Policy Assignment Description 2"
      policyDefName             = "Sample Policy definit~Tion 2"
      policyAsgnParameters      = <<PARAMS
        {
          "tagName":{
              "value": "Environment"
          },
          "tagValue1":{
              "value": "Prod"
          },
          "tagValue2":{
              "value": "Dev"
          }
        }
      PARAMS
    }
  ]
}


variable "subscription_id" {
  description = "Enter Subscription ID for provisioning resources in Azure"
}

variable "client_id" {
  description = "Enter Client ID for Application created in Azure AD"
}

variable "client_secret" {
  description = "Enter Client Secret for Application created in Azure AD"
}

variable "tenant_id" {
  description = "Enter Tenant ID of your Azure AD."
}