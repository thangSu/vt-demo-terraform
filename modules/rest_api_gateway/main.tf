resource "aws_api_gateway_rest_api" "api" {
  name = "students"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
  tags = {
    "Environment" = "terraform"
  }
}
resource "aws_api_gateway_resource" "api_resource" {
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = var.api_res_path
  rest_api_id = aws_api_gateway_rest_api.api.id
  depends_on = [
    aws_api_gateway_rest_api.api
  ]
}

resource "aws_api_gateway_authorizer" "api_authorizer" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  name = "dev-coginto-authorizer"
  type = "COGNITO_USER_POOLS"
  provider_arns = [var.cognito_arn]
  identity_source = "method.request.header.Authorization"
}
resource "aws_api_gateway_method" "method" {
  count = length(var.api_method)
  http_method   = "${var.api_method[count.index]}"
  resource_id   = aws_api_gateway_resource.api_resource.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
  api_key_required = false
  depends_on = [
    aws_api_gateway_resource.api_resource
  ]
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.api_authorizer.id
}
resource "aws_api_gateway_integration" "api_integration" {
  count = length(var.api_method)
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.api_resource.id
  http_method             = aws_api_gateway_method.method[count.index].http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_invoke_arn[count.index]
  depends_on = [
    aws_api_gateway_resource.api_resource
  ]
}
resource "aws_api_gateway_method_response" "api_method_response_200" {
  count = length(var.api_method)
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.api_resource.id
  http_method = aws_api_gateway_method.method[count.index].http_method
  status_code = "200"
  response_models  ={
    "application/json" = "Empty"
  }
  depends_on = [
    aws_api_gateway_resource.api_resource
  ]
}
resource "aws_lambda_permission" "api_lambda_permission" {
  count = length(var.lambda_function_name)
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "${var.lambda_function_name[count.index]}"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/${var.api_method[count.index]}/${var.api_res_path}"
}

resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.api.body))
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_api_gateway_integration.api_integration
  ]
}

resource "aws_api_gateway_stage" "api_stage" {
  deployment_id = aws_api_gateway_deployment.api_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = "dev"
  tags = {
    "Environment" = "terraform"
  }
}