import json
import boto3

dynamodb=boto3.resource('dynamodb')

def lambda_handler(event, context):
    primary_key={"studentcode": event["studentcode"]}
    table = dynamodb.Table("students")
    res = table.update_item(
        Key=primary_key,
        UpdateExpression="SET name= :name, class= :class",
        ExpressionAttributeValues={
            ":name": event["params"]["querystring"]["name"],
            ":class" : event["params"]["querystring"]["class"]
        })
    res1 = table.get_item(Key = primary_key)
    return {
        'check_result': res1['Item']
    }
