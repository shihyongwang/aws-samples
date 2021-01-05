## Create your CodeDeploy pipeline
1. Read the [appspec.yml user guide](https://docs.aws.amazon.com/codedeploy/latest/userguide/reference-appspec-file.html) , event hooks at this case run in the following order:
<img alt="CodeDeploy hook" src="https://docs.aws.amazon.com/codedeploy/latest/userguide/images/lifecycle-event-order-blue-green.png">

2. Make sure you already with proper configuration.
```bash
$ export AWS_DEFAULT_REGION=us-east-1
$ aws configure list
$ aws sts get-caller-identity
```

3. Edit the file `bin/newversion.sh` to meet your environment (such as S3Bucket, BlueGreenApp). Then upload your artifact via `bin/newversion.sh`, you will get the following output.
```bash
$ aws deploy create-deployment --application-name YOU_APP_NAME --s3-location bucket=YOUR_BUCKET,key=newversion.zip,bundleType=zip,eTag=XXYYZZ --deployment-group-name <deployment-group-name> --deployment-config-name <deployment-config-name> --description <description>
```

4. But we'd like to deploy application via **AWS console** (rather than the above command) `CodeDeploy` --> `Applicaitons` --> `Deployment groups`, then choose which deployment group to `Edit`
<img width="812" alt="Edit the deployment group - type & env" src="https://user-images.githubusercontent.com/13880010/91653583-be022780-ead4-11ea-9e01-043a7e322730.png">
<img width="811" alt="Edit the deployment group - lb" src="https://user-images.githubusercontent.com/13880010/91652877-b2f7c900-eacd-11ea-82dd-301b15fdf7ca.png">
<img width="721" alt="Edit the deployment group - deploy behavior" src="https://user-images.githubusercontent.com/13880010/103603811-71c76800-4f4a-11eb-99c6-217501284f38.png">

5. If every parameters seems fine, then click `Create deployment`
<img width="1048" alt="Create deployment" src="https://user-images.githubusercontent.com/13880010/91652934-4f21d000-eace-11ea-8ae4-124ba9fa1887.png">

6. At the Create deployment page, Choose the `Revision location` from your S3 location.
<img width="812" alt="Revision location" src="https://user-images.githubusercontent.com/13880010/91653006-01599780-eacf-11ea-856d-1bcdd23271e9.png">

7. If you stay at the deployment page, you will have such as status
<img width="1048" alt="Deployment status" src="https://user-images.githubusercontent.com/13880010/91654180-66b28600-ead9-11ea-82a8-cd119717eb2c.png">
<img width="1047" alt="Deployment status" src="https://user-images.githubusercontent.com/13880010/91654184-687c4980-ead9-11ea-957e-f8ad2550e4e0.png">

8. If you successed the deployment, you can check the ALB
<img width="825" alt="Congratulations" src="https://user-images.githubusercontent.com/13880010/91654248-cf016780-ead9-11ea-82f3-c9a4346fa437.png">

## Reference
- [Performing Blue/Green Deployments with AWS CodeDeploy and Auto Scaling Groups](https://aws.amazon.com/blogs/devops/performing-bluegreen-deployments-with-aws-codedeploy-and-auto-scaling-groups/)
- [Automating Blue/Green Deployments of Infrastructure and Application Code](https://aws.amazon.com/blogs/devops/bluegreen-infrastructure-application-deployment-blog/)
- [Under the Hood: AWS CodeDeploy and Auto Scaling Integration](https://aws.amazon.com/blogs/devops/under-the-hood-aws-codedeploy-and-auto-scaling-integration/)

