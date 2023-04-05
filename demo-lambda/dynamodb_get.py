import json
import boto3

dynamodb=boto3.resource("dynamodb")

def lambda_handler(event, context):
    # TODO implement
    primary_key={'id' : int(event["params"]["querystring"]['id'])}
    table = dynamodb.Table('students')
    res = table.get_item(Key=primary_key)
    return res['Item']
