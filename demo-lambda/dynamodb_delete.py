import json
import boto3
dynamodb = boto3.resource("dynamodb")
def lambda_handler(event, context):
    table = dynamodb.Table("student")
    primary_key = {"id":  event['queryStringParameters']['id']}
    
    res = table.delete_item(Key= primary_key)
    return {
    'statusCode': 200,
    'body': json.dumps(res),
    }