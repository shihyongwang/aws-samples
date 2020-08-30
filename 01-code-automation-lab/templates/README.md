## AWS CloudFormation
AWS CloudFormation provides a common language for you to model and provision AWS infrastructure resources. Check [the official site](https://aws.amazon.com/cloudformation/) for more information.

### Sample architecture on AWS
![3 tiers on AWS - shihyong](https://user-images.githubusercontent.com/13880010/91656797-201b5680-eaee-11ea-9529-c6b403477384.jpg)

#### Storage layer
- Create a bucket for object storage
- Create a bucket for access logs
- Create Lifecycle to objects

#### Network layer
- Enable 2 AZs at the destination VPC.
- Create 3 subnets at each AZ.
  - public subnets for bastion box, NAT gateway.
  - private subnets for Web, App, ElastiCache, AES, etc.
  - private subnets for database.
- Could create the 4th subnets for transit purpose (for safety manner)

#### Bastion layer
- Instance type "t" should be enough. But Spot is not preferred.
- A jump box could without EBS.
- Protect the bastion with ASG to make sure there is always one box online.
- Regarding the CIDR at SG, allow from corp NAT is preferred.
- At this moment, this bastion would with permission to access such as S3, CodeDeploy, ECS, Lambda, etc.

#### Application layer
- Create the ALB at public subnets. (CLB would be EOLed)
- Create the ASG at private subnets,
- Create SG by only allowing traffic from 0.0.0.0/0 via port 80 and 443.
- At this moment, there are always at least 2 instances online.
- EC2 instances are created with EBS friendly.
- In addition, this template also sets up an AWS CodeDeploy application and blue/green deployment group.

### Step by step
#### Storage layer
1. Go to `CloudFormation` (or URL: _https://console.aws.amazon.com/cloudformation/home?region=us-east-1_ ) to `Create stack`
<img width="1010" alt="S3 bucket" src="https://user-images.githubusercontent.com/13880010/91656774-eba79a80-eaed-11ea-9905-7d016b81ec4e.png">

#### Network layer
1. Go to `CloudFormation` (or URL: _https://console.aws.amazon.com/cloudformation/home?region=us-east-1_ ) to `Create stack`
<img width="1334" alt="Step 1" src="https://user-images.githubusercontent.com/13880010/91627400-a9953080-e9e9-11ea-9fd3-004bc9c41696.png">

2. Put the parameters
<img width="1018" alt="Step 2" src="https://user-images.githubusercontent.com/13880010/91627453-0e508b00-e9ea-11ea-862e-e2d3c2028ebe.png">

3. Directly `Next` at step 3

4. Final `Review` to create this stack.

5. This creation step might take about 3 minutes.

6. Finally, check the `Outputs` results
<img width="989" alt="Outputs" src="https://user-images.githubusercontent.com/13880010/91628270-a2bdec00-e9f0-11ea-9c89-3be8ba449249.png">


#### Bastion layer
1. At `Step 1`, specify stack details as 
<img width="647" alt="Step 1" src="https://user-images.githubusercontent.com/13880010/91628013-48bc2700-e9ee-11ea-8a56-383917b9abd2.png">

2. At `Step 3`, you must check the _I acknowledge that AWS CloudFormation might create IAM resources with custom names._
<img width="1019" alt="Step 3" src="https://user-images.githubusercontent.com/13880010/91628053-aea8ae80-e9ee-11ea-87bb-d4fda78da538.png">

3. This step might take about 4 minutes.

#### Workstation layer
<img width="972" alt="Workstation" src="https://user-images.githubusercontent.com/13880010/91657019-59ed5c80-eaf0-11ea-808f-120ed502d3b9.png">

#### Application layer
1. At `Step 1`, specify stack details as 
<img width="638" alt="Step 1" src="https://user-images.githubusercontent.com/13880010/91628382-d2b9bf00-e9f1-11ea-9ca5-ffe1db34d8a4.png">

2. At `Step 3`, you must also check the _I acknowledge that AWS CloudFormation might create IAM resources with custom names._
<img width="1019" alt="Step 3" src="https://user-images.githubusercontent.com/13880010/91628053-aea8ae80-e9ee-11ea-87bb-d4fda78da538.png">

3. This step might take about 3 minutes.

4. Finally, check the `Outputs` results
<img width="867" alt="Outputs" src="https://user-images.githubusercontent.com/13880010/91628639-4a88e900-e9f4-11ea-8ebc-eea7d39ad8ab.png">

5. If clicked the `ElbDNS` in a separate browser tab, you will get a test page such as
<img width="1285" alt="Test Page" src="https://user-images.githubusercontent.com/13880010/91628697-fcc0b080-e9f4-11ea-86af-b615aee1d78d.png">


### Reference
- Per [https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-validate-template.html](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-validate-template.html) , you could validate your YAML via CLI:
```bash
aws cloudformation validate-template --template-body files:///home/YOUR_ID/YOUR_PATH/cfn_YOUR_STACK.yaml
```
- [AWS CloudFormation Best Practices](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/best-practices.html)
- [AWS CloudFormation Template Reference](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-reference.html)
- [CFN lint for VSCode](https://github.com/awslabs/aws-cfn-lint-visual-studio-code)
- [Use AWS CloudFormer to create CloudFormation Template](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cfn-using-cloudformer.html)
- [Import Existing Resources into a CloudFormation Stack](https://aws.amazon.com/blogs/aws/new-import-existing-resources-into-a-cloudformation-stack/)

### Free CloudFormation Templates
- [CloudFormation Guard](https://github.com/aws-cloudformation/cloudformation-guard)
- [https://github.com/awslabs/aws-cloudformation-templates](https://github.com/awslabs/aws-cloudformation-templates)
- [https://github.com/aws-cloudformation/awesome-cloudformation](https://github.com/aws-cloudformation/awesome-cloudformation)
- [https://templates.cloudonaut.io/en/stable/](https://templates.cloudonaut.io/en/stable/)

