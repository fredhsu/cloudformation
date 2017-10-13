aws cloudformation create-stack --region ca-central-1 \
	--stack-name "ONUG" \
	--template-body file://onug.yaml \
	--parameters VPCCidr="10.1.0.0/16",Subnet1Cidr="10.1.1.0/24",Subnet2Cidr="10.1.11.0/24",VPCName=VPC-1

