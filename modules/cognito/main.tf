resource "aws_cognito_user_pool" "cognito_user_pool" {
    name = var.user_pool_name

    alias_attributes = ["email","preferred_username"]
    auto_verified_attributes = ["email"]

    account_recovery_setting {
        recovery_mechanism {
            name = "verified_email"
            priority = 1
        } 
    }

    verification_message_template {
        default_email_option = "CONFIRM_WITH_CODE"
        email_subject = var.email_subject
    }
    username_configuration {
        case_sensitive = false
    }
    password_policy {
        minimum_length = 8
        require_lowercase = true
        require_uppercase = true
        require_numbers = true
    }
    user_attribute_update_settings {
        attributes_require_verification_before_update = [ "email" ]
    }
    schema {
        attribute_data_type = "String"
        developer_only_attribute = false 
        mutable = true
        name ="email"
        required = true
        string_attribute_constraints {
            min_length = 1
            max_length = 256
        }
    }
}
resource "aws_cognito_user_pool_client" "aws_user_pool_client" {
    name = var.client_pool_name
    user_pool_id = aws_cognito_user_pool.cognito_user_pool.id
    generate_secret = var.generate_secret
    refresh_token_validity = 90
    prevent_user_existence_errors = "ENABLED"
    explicit_auth_flows = [
        "ALLOW_REFRESH_TOKEN_AUTH",
        "ALLOW_USER_PASSWORD_AUTH",
        "ALLOW_ADMIN_USER_PASSWORD_AUTH" 
    ]
}


resource "aws_cognito_user_pool_domain" "cognito_domain" {
    domain = var.cognito_domain
    user_pool_id = aws_cognito_user_pool.cognito_user_pool.id
}