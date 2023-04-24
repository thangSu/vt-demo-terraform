# resource "aws_api_gateway_api_key" "api_key" {
#     name = "dev_key"
# }
# resource "aws_api_gateway_usage_plan" "api_plan" {
#     name = "dev_plan"
#     api_stages {
#         api_id = aws_api_gateway_rest_api.api.id
#         stage = aws_api_gateway_stage.api_stage.stage_name
#     }
#     quota_settings {
#         limit = 20
#         offset = 2
#         period = "WEEK"
#     }
#     throttle_settings {
#         burst_limit = 5
#         rate_limit = 10
#     }
# }
# resource "aws_api_gateway_usage_plan_key" "api_usage_key" {
#     key_id = aws_api_gateway_api_key.api_key.id
#     key_type = "API_KEY"
#     usage_plan_id = aws_api_gateway_usage_plan.api_plan.id
# }
