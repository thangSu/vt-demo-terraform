import json
import boto3
import urllib3
def lambda_handler(event, context):
    #upload()
    delete()
    res1 = list();
    res2 = object_list("thangdeptrai");
    res3 = object_list("saophaixoa");
    return {
        "list" : res1,
        "object_list_1" : res2,
        "object_list_2" : res3
    }
def list():
    s3=boto3.client('s3')
    print("== s3 bucket list: ===")
    # TODO implement
    
    buckets=s3.list_buckets()
    list = []
    for bucket in buckets['Buckets']:
        print(bucket.get('Name'))
        list.append(bucket.get('Name'))
    return list

def object_list(name):
    s3 = boto3.resource("s3")
    bucket = s3.Bucket(name)
    print("== s3 objects list "+name+": ===")
    result = bucket.meta.client.list_objects(Bucket=bucket.name, Delimiter='/')
    list = []
    for o in result.get('Contents'):
        print(o.get('Key'))
        list.append(o.get('Key'))
    return list
    
def upload():
    s3 = boto3.client('s3')
    http = urllib3.PoolManager()
    response = http.request('GET', "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpZyyZdeD_wIigmjzNd409rDx-vWt3aZHwOA&usqp=CAU",preload_content=False)
    
    s3.upload_fileobj(response,"thangdeptrai","gaixinh.jpg")
    
def delete():
    s3 = boto3.client('s3')
    s3.delete_object(Bucket="thangdeptrai",Key="gaixinh.jpg")
