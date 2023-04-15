module "dynamodb" {
  source = "./modules/dynamodb"
}

module "lambda" {
  source       = "./modules/lambda"
  dynamodb_arn = module.dynamodb.dynamodb_arn
  depends_on = [
    module.dynamodb
  ]
  source_file = [
    "demo-lambda/dynamodb_get.py",
    "demo-lambda/dynamodb_delete.py",
    "demo-lambda/dynamodb_insert.py",
    "demo-lambda/dynamodb_modify.py"
  ]
  output_path = [
    "demo-lambda/zip/dynamodb_get.zip",
    "demo-lambda/zip/dynamodb_delete.zip",
    "demo-lambda/zip/dynamodb_insert.zip",
    "demo-lambda/zip/dynamodb_modify.zip",
  ]
}

module "rest-api-gateway" {
  source               = "./modules/rest_api_gateway"
  lambda_function_name = module.lambda.lambda_name
  lambda_invoke_arn    = module.lambda.lambda_invoke_arn
  depends_on = [
    module.lambda
  ]
}