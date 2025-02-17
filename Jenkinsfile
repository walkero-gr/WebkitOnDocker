pipeline {
	agent any
	stages {
		stage('aws-poweron') {
			environment {
				AWS_CREDS=credentials('aws-ec2-credentials')
				AWS_DEFAULT_REGION="eu-north-1"
			}
			// agent {
			// 	docker {
			// 		image 'amazon/aws-cli'
			// 		args '-e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} -e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}'
			// 	}
			// }
			steps {
				sh '''
					aws ec2 describe-instances
					aws ec2 start-instances --instance-ids i-07474e4fe80f14754 i-02bb3cbe63a2b3fef
				'''
			}
		}
	}
}