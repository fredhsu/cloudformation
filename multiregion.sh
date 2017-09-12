#regions="us-west-2 us-east-2 eu-west-1 ap-southeast-2 ap-northeast-1"
# regions="us-west-2 eu-west-1 ap-southeast-2"
# regions="us-west-2"
regions="us-west-2 us-east-2 eu-west-1 ap-southeast-2 ap-northeast-1"
for r in $regions; do
    aws cloudformation create-stack \
        --region $r \
        --stack-name "CT-$r" \
        --template-body file://multiregion-ec2.yaml
done

