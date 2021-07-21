variable "policyDefintion" {
  type = list(any)
  description = "Details of the policy definition"
  default = [
    {
      policyDefName         = "Sample Policy Definition 1"
      policyDefDescription  = "Sample Policy Definition Description"
      policyType            = "Custom"
      mode                  = "all"
      category              = "Sample"
      policyDefRule = <<RULE
        {
            "if": {
              "not": {
                  "anyOf":[
                  {
                      "field": "[concat('tags[', parameters('tagName'), ']')]",
                      "equals": "[parameters('tagValue1')]"
                  },
                  {
                      "field": "[concat('tags[', parameters('tagName'), ']')]",
                      "equals": "[parameters('tagValue2')]"
                  },
                  {
                      "field": "[concat('tags[', parameters('tagName'), ']')]",
                      "equals": "[parameters('tagValue3')]"
                  }
                  ]
              }
          },
          "then": {
              "effect": "audit"
          }
        }
      RULE
      policyDefParams = <<DEFPARAMS
        {
          "tagName": {
              "type": "String",
              "metadata": {
                  "displayName": "Tag Name",
                  "description": "Name of the tag such as APPS"
              }
          },
          "tagValue1": {
              "type": "String",
              "metadata": {
                  "displayName": "Tag Value 1",
                  "description": "Name of the tag such as APIM"
              }
          },
          "tagValue2": {
              "type": "String",
              "metadata": {
                  "displayName": "Tag Value 2",
                  "description": "Name of the tag such as APIM"
              }
          },
          "tagValue3": {
              "type": "String",
              "metadata": {
                  "displayName": "Tag Value 3",
                  "description": "Name of the tag such as APIM"
              }
          }
        }
      DEFPARAMS
    },
    {
      policyDefName         = "Sample Policy Definition 2"
      policyDefDescription  = "Sample Policy Definition Description"
      policyType            = "Custom"
      mode                  = "all"
      category              = "Sample"
      policyDefRule = <<RULE
        {
            "if": {
              "not": {
                "anyOf":[
                  {
                      "field": "[concat('tags[', parameters('tagName'), ']')]",
                      "equals": "[parameters('tagValue1')]"
                  },
                  {
                      "field": "[concat('tags[', parameters('tagName'), ']')]",
                      "equals": "[parameters('tagValue2')]"
                  }
                ]
              }
          },
          "then": {
              "effect": "audit"
          }
        }
      RULE
      policyDefParams = <<DEFPARAMS
        {
          "tagName": {
              "type": "String",
              "metadata": {
                  "displayName": "Tag Name",
                  "description": "Name of the tag such as APPS"
              }
          },
          "tagValue1": {
              "type": "String",
              "metadata": {
                  "displayName": "Tag Value 1",
                  "description": "Name of the tag such as APIM"
              }
          },
          "tagValue2": {
              "type": "String",
              "metadata": {
                  "displayName": "Tag Value 2",
                  "description": "Name of the tag such as APIM"
              }
          }
        }
      DEFPARAMS
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

