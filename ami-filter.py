""" This script allow us to filter the amis by name an latest creation date
"""

import boto3

sesion = boto3.session.Session(profile_name="strln")

ec2_client = sesion.client("ec2")

response = ec2_client.describe_images(
    Filters=[{"Name": "name", "Values": ["concourse-*"]}]
)

sorted_response = sorted(response["Images"], key=lambda x: x["CreationDate"])

latest_images = []

for image in sorted_response:

    latest_images.append(image["ImageId"])

print(latest_images[-1])