""" This script allow us to filter the amis by name an latest creation date
"""
import os
import boto3

ACCESS_KEY= os.getenv("AWS_ACCESS")
SECRET_KEY= os.getenv("AWS_SECRET")

session = boto3.Session(
    aws_access_key_id=ACCESS_KEY ,
    aws_secret_access_key=SECRET_KEY
)


ec2_client = session.client("ec2", region_name='us-west-2')

response = ec2_client.describe_images(
    Filters=[{"Name": "name", "Values": ["concourse-*"]}]
)

sorted_response = sorted(response["Images"], key=lambda x: x["CreationDate"])

latest_images = []

for image in sorted_response:

    latest_images.append(image["ImageId"])

print(latest_images[-1])