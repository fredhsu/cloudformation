# AWS CloudFormation Examples
## ec2-basic.json
* When I created with these basic settings, it automatically added a network interface, put it in my VPC on a subnet, and assigned it to the default security group.
* Without specifying the InstanceType I kept getting error:

    Non-Windows instances with a virtualization type of 'hvm' are currently not supported for this instance type.

When I got this error it would rollback and remove everything it created

    aws cloudformation create-stack --stack-name test6 --template-body file:///$HOME/code/aws/cloudformation/ec2-basic.json

    {
    "StackId": "arn:aws:cloudformation:us-west-1:177340232285:stack/test6/abbb3e60-f305-11e6-acc6-50faf037148d"
    }

* Deleting the stack cleans it all up

    aws cloudformation delete-stack --stack-name test6

## ec2-sg.json
* This template adds to the first with a security group parameter definition
* Added `InstanceSecurityGroup` as another resource, then we refer to it as a property with a `ref` to it.  The resource name is a key to the value of the resource

## ec2-nic.json
* Adding a network interface using NetworkInterfaces
* If I add more than one in that array, then it will only give private.  To have one public and multiple private then I have to add one using this and then do addInterface for the privates.
* Requires subnetId
* Setting SourceDestCheck to false
* Network interfaces and an instance-level security groups may not be specified on the same request
    * Will resolve next time with a VPC level security group
* Automatically assigned both public and private IP addresses

## vpc.json
* Create a simple VPC with default settings and CIDR of 10.0.0.0/16

## vpc-sg-igw.json
* Create VPC
* Add security group to vpc
* create internet gateway
* Attach igw to the VPC
* Does not create subnet by default

## vpc-sg-igw-subnet-ec2.json
* Create VPC with security group, igw, and multiple subnets within the CIDR
* Create network interfaces in the subnets
* Attach the network interfaces to an EC2
* Launch EC2 with multiple subnets
* One subnet is designed to go outside, so assign public IP automatically on that one
* Have to move to c4.large to support 3 interfaces
* Cannot use instance level security groups and add NICs, instead add the SGs on the NIC config
    * For outside interface use defined security group to only allow specific traffic
    * Default SG allows everything on other interfaces
* Can't SSH due to route table config.  Need to associate route table with the subnets and point default route to igw

## vpc-sg-igw-subnet-ec2-rt.json
* *in progress*
* Same as above, but now adding in route tables for the subnets
* For mgmt/outbound subnet add a default route pointing to igw
* For other subnets default route points to the NICs from above
* RouteTable
* routes -- may need DependsOn to make sure igw and nics are there
    * DependsOn take a list of strings that refer to the key names of the objects, not the object IDs (i.e. dont' need a ref)
* SubnetRouteTableAssociation
* Notice that the creation of the vpc creates a *Main* route table, but there is no way to reference it and it doesn't really need to be used.  Just means we have to explicitly create all the route tables and can't reuse that onej
    * https://forums.aws.amazon.com/thread.jspa?threadID=97060
* Have to use NetworkInterfaceId instead of GatewayId for the routes that point to the VM interfaces


## vpc-sg-igw-subnet-ec2-rt-config.json
* Now assigning static IP addresses to the network interfaces to use for the config
* Need to grab the private IP of the interfaces and assign that to the config of the switch
* Apply the config to the image as part of bootup


## plus use ElasticIP
## Add EC2 to second AZ
## End goal
Create one vpc with:
* Two AZ's
* Multiple subnets that will attach to NICs an EC2 instance (*rtr*)
* Use user text to configure the *rtr* instance
* Security groups for those subnets to allow traffic to flow
* Set route tables for each subnet to point to these EC2 interfaces
* Other EC2 instances that will use those routes to forward traffic to rtr instances
* Repeat in a 2nd AZ 


## cross-stack reference
http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/walkthrough-crossstackref.html

## Example run:

    aws cloudformation create-stack --template-body file:///$HOME/code/aws/cloudformation/vpc-sg-igw.json --stack-name test13
    aws cloudformation create-stack --template-body file:///$HOME/code/aws/cloudformation/lob1vpc.json --stack-name lob1

    aws cloudformation wait stack-create-complete

    aws cloudformation delete-stack --stack-name test13

## Example with cross stack:
    * Create VPC

    $ aws cloudformation create-stack --template-body file:///$HOME/code/aws/cloudformation/lobvpc.json --stack-name lobvpc

    * Create LOB1

    $ aws cloudformation create-stack --template-body file:///$HOME/code/aws/cloudformation/lob1vpc.json --stack-name lob1

    * Create LOB2
    * Create TransitVPC

## Questions/Notes
* How to integrate into CI/CD
* Could have a CF template that deploys new version of app when build is done
* github.com/cloudtools/troposphere
* Use a template to create and manage a *stack*
* When I go this error message `An error occurred (ValidationError) when calling the CreateStack operation: Template format error: unsupported structure.` it meant that I mistyped a parameter when running `aws cloudformation` CLI.  
* How do I address the subnets/generate them.. maybe scripting
* Script the building of the template
* Do we need a route table per subnet, or can we use one RT to service multiple subnets?  
