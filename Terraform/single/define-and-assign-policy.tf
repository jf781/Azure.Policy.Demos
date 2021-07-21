variable "policyDefName" {
    type = string
    default = "Sample Policy Definition"
    description = "Name of the policy definition"
}

variable "policyDefDescription" {
    type = string
    default = "Sample Policy Definition Description2"
    description = "Description for the policy definition"
}

variable "policyAsgnName" {
    type = string
    default = "Sample Policy Assignment"
    description = "Name of the policy assignment"
}

variable "policyAsgnDescription" {
    type = string
    default = "Sample Policy Assignment Descriptions"
    description = "Description used for the policy assignment"
}

variable "rgName" {
    type = string
    default = "JF-AzPolicy-Demo"
    description = "Name of the resource group.  Used for scoping policy assignment"
}

variable "tagName" {
    type = string
    default = "Environment"
    description = "Tag name which you are checking tag values for"
}

variable "tagValue1" {
    type = string
    default = "Prod"
    description = "A tag value you a searching for"
}

variable "tagValue2" {
    type = string
    default = "QA"
    description = "A tag value you a searching for"
}

variable "tagValue3" {
    type = string
    default = "Dev"
    description = "A tag value you a searching for"
}

data "azurerm_subscription" "sub" { 
}


data "azurerm_resource_group" "rg" {
    name = var.rgName
}


resource "azurerm_policy_definition" "policy" {
    name            = var.policyDefName
    policy_type     = "Custom"
    mode            = "Indexed"
    display_name    = var.policyDefName
    description     = var.policyDefDescription

    metadata = <<METADATA
    {
        "CATEGORY": "DemoCategory"
    }
    METADATA

    policy_rule = <<POLICY_RULE
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
    POLICY_RULE

    parameters = <<PARAMETERS
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
    PARAMETERS
}

resource "azurerm_policy_assignment" "assignment" {
    name                    = var.policyAsgnName
    scope                   = data.azurerm_subscription.sub.id
    policy_definition_id    = azurerm_policy_definition.policy.id
    description             = var.policyAsgnDescription
    display_name            = var.policyAsgnName
    depends_on              = [azurerm_policy_definition.policy]

    parameters = <<PARAMETERS
    {
        "tagName":{
            "value": "${var.tagName}"
        },
        "tagValue1":{
            "value": "${var.tagValue1}"
        },
        "tagValue2":{
            "value": "${var.tagValue2}"
        },
        "tagValue3":{
            "value": "${var.tagValue3}"
        }
    }
    PARAMETERS
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

