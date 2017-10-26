#regions="us-west-2 us-east-2 eu-west-1 ap-southeast-2 ap-northeast-1"
# regions="us-west-2 eu-west-1 ap-southeast-2"
# regions="us-west-2"
for i in `seq 1 40`; do
    aws cloudformation delete-stack \
        --region ca-central-1 \
        --profile selab \
        --stack-name "vpc-$i" 
done
