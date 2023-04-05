resource "aws_dynamodb_table" "basic-dynamodb-table"  {
    name     = "students"
    hash_key = "id"
    billing_mode = "PROVISIONED"
    read_capacity = 5
    write_capacity = 5

    attribute {
      name = "id"
      type = "N"
    }
    tags = {
        Name = "students"
    }
}