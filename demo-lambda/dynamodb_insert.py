import json
import boto3
def lambda_handler(event, context):
    dynamodb=boto3.resource('dynamodb')
    table=dynamodb.Table('students')
    res= table.put_item(
        Item={
            'id': event["params"]["querystring"]["id"],
            'name': event["params"]["querystring"]["name"]
        }
        )
    return {
        'statusCode': res,
    }
