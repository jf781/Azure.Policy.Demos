resource "azurerm_policy_definition" "policy" {
    count           = length(var.policyDefintion)
    name            = var.policyDefintion[count.index].policyDefName
    policy_type     = var.policyDefintion[count.index].policyType
    mode            = var.policyDefintion[count.index].mode
    display_name    = var.policyDefintion[count.index].policyDefName
    description     = var.policyDefintion[count.index].policyDefDescription
    policy_rule     = var.policyDefintion[count.index].policyDefRule
    parameters      = var.policyDefintion[count.index].policyDefParams
    metadata        = <<METADATA
        {
            "CATEGORY": "${var.policyDefintion[count.index].category}"
        }
    METADATA
}