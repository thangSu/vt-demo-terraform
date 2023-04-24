# output "api_key_value" {
#     value = [aws_api_gateway_api_key.api_key.value]
# }
output "api_invoke_url" {
    value = [aws_api_gateway_stage.api_stage.invoke_url]
}