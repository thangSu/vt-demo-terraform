variable "table_name" {
    type = string 
    default = "student"
}
variable "primary_key" {
    type = string
    default = "id"
}
variable "billing_mode" {
    type = string
    default = "PROVISIONED"
}
