variable "api_res_path"{
    type = list
    default = ["get_student" , "delete_student", "insert_student" , "modify_student"]
}
variable "api_method" {
    type = list 
    default =["GET","DELETE","POST", "PUT"]
}