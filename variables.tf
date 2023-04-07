variable "lambda_name" {
    type = list
    default = ["get_db","delete_db","insert_db","modify_db"]
}

variable "python_file" {
    type = list
    default = ["dynamodb_get", "dynamodb_delete", "dynamodb_insert","dynamodb_modify"]
}
variable "api_res_path"{
    type = list
    default = ["get_student" , "delete_student", "insert_student" , "modify_student"]
}
variable "api_method" {
    type = list 
    default =["GET","DELETE","PUT", "POST"]
}