#regions="us-west-2 us-east-2 eu-west-1 ap-southeast-2 ap-northeast-1"
# regions="us-west-2 eu-west-1 ap-southeast-2"
# regions="us-west-2"
for i in `seq 10 15`; do
    aws cloudformation create-stack \
        --region ca-central-1 \
        --stack-name "vpc-$i" \
        --template-body file://onug.yaml \
        --profile selab \
        --parameters ParameterKey=ID,ParameterValue=$i \
        ParameterKey=VPCCidr,ParameterValue=10.$i.0.0/16 \
        ParameterKey=Subnet1Cidr,ParameterValue=10.$i.1.0/24 \
        ParameterKey=Subnet2Cidr,ParameterValue=10.$i.11.0/24
done