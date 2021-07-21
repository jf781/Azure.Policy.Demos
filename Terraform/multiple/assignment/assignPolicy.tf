data "azurerm_resource_group" "rg" {
    name = var.rgName
}

data "azurerm_subscription" "sub" { 
}

data "azurerm_policy_definition" "defintion" {
    count = length(var.policyAssignment)
    name = var.policyAssignment[count.index].policyDefName
}

resource "azurerm_policy_assignment" "assignment" {
    count                   = length(var.policyAssignment)
    name                    = var.policyAssignment[count.index].policyAsgnName
    scope                   = data.azurerm_subscription.sub.id
    policy_definition_id    = data.azurerm_policy_definition.defintion[count.index].id
    description             = var.policyAssignment[count.index].policyAsgnDescription
    display_name            = var.policyAssignment[count.index].policyAsgnName
    depends_on              = [data.azurerm_policy_definition.defintion]
    parameters              = var.policyAssignment[count.index].policyAsgnParameters
}