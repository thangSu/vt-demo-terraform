resource "aws_dynamodb_table" "student-table"  {
    name     = "${var.table_name}"
    hash_key = "${var.primary_key}"
    billing_mode = "${var.billing_mode}"
    read_capacity = 5
    write_capacity = 5

    attribute {
      name = "${var.primary_key}"
      type = "S"
    }
    tags = {
        Name = "${var.table_name}"
    }
}