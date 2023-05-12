variable "api_res_path"{
    type = string
    default = "student"
}
variable "api_method" {
    type = list 
    default =["GET","DELETE","POST", "PUT"]
}

variable "lambda_function_name" {
    type = list
}
variable "lambda_invoke_arn" {
    type = list
}

variable "cognito_arn" {
    type = string
}
