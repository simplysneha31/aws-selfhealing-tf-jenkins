import boto3

def lambda_handler(event, context):
    instance_id = event['detail']['configuration']['metrics'][0]['metricStat']['metric']['dimensions'][0]['value']
    ec2 = boto3.client('ec2')
    
    response = ec2.reboot_instances(InstanceIds=[instance_id])
    return {
        'statusCode': 200,
        'body': f'Restarted instance {instance_id}'
    }
