import json
import boto3

dynamodb=boto3.resource('dynamodb')

def lambda_handler(event, context):
    primary_key={"id": event['queryStringParameters']['id']}
    table = dynamodb.Table("student")
    res = table.update_item(
        Key=primary_key,
        UpdateExpression='SET studentname= :studentname, studentclass= :studentclass',
        ExpressionAttributeValues={
            ':studentname' : event['body']['studentname'],
            ':studentclass' : event['body']['studentclass']
        })
    return {
    'statusCode': 200,
    'body': json.dumps(event),
    }
