variable "user_pool_name" {
    type = string   
}

variable "email_subject" {
    type = string
}

variable "client_pool_name" {
    type = string
}
variable "generate_secret" {
    type = bool
}
variable "cognito_domain" {
    type= string
}