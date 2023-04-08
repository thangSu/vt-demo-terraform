import json
import boto3

dynamodb=boto3.resource("dynamodb")

def lambda_handler(event, context):
    # TODO implement
    primary_key={'id' :  event['queryStringParameters']['id']}
    table = dynamodb.Table('student')
    res = table.get_item(Key=primary_key)
    return {
    'statusCode': 200,
    'body': json.dumps(res["Item"]),
    }
