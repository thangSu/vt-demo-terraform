# output "api_key_value" {
#     value = [module.rest-api-gateway.api_key_value]
#     sensitive = true
# }
output "api_invoke_url"{
    value = [module.rest-api-gateway.api_invoke_url]
}