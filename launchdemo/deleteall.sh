
# Delete VPC Peer
aws cloudformation delete-stack --stack-name peer
# Delete lob1
aws cloudformation delete-stack --stack-name lob1
# Delete lob2
aws cloudformation delete-stack --stack-name lob2
# Wait for lobs to delete
aws cloudformation wait stack-delete-complete --stack-name lob1
aws cloudformation wait stack-delete-complete --stack-name lob2
# Delete LOB VPC
aws cloudformation delete-stack --stack-name lobvpc
# Delete Transit VPC
aws cloudformation delete-stack --stack-name transit
