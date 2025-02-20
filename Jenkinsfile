def BUILD_TAG = "experimental"

pipeline {
	agent any
	environment {
		DOCKERHUB_CREDS=credentials('walkero-dockerhub')
		AWS_CREDS=credentials('aws-ec2-credentials')
		AWS_DEFAULT_REGION="eu-north-1"
		REPO="walkero/webkitondocker"
	}
	stages {
		stage('Init') {
			when { buildingTag() }
			steps {
				script {
					if (env.TAG_NAME) {
						BUILD_TAG = "${TAG_NAME}"
					}
				}
			}
		}
		stage('aws-poweron') {
			when { buildingTag() }
			steps {
				sh '''
					aws ec2 start-instances --instance-ids i-07474e4fe80f14754 i-02bb3cbe63a2b3fef
				'''
			}
		}
		stage('build-images') {
			when { buildingTag() }
			matrix {
				axes {
					axis {
						name 'ARCH'
						values 'amd64', 'arm64'
					}
				}
				agent { label "aws-${ARCH}" }
				stages {
					stage('build') {
						steps {
							sh '''
								docker build --cache-from ${REPO}:latest-${ARCH} -t ${REPO}:${BUILD_TAG}-${ARCH} -t ${REPO}:latest-${ARCH}  -f Dockerfile .
							'''
						}
					}
					stage('dockerhub-login') {
						steps {
							sh '''
								echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin
							'''
						}
					}
					stage('push-images') {
						steps {
							sh '''
								docker push ${REPO}:${BUILD_TAG}-${ARCH}
								docker push ${REPO}:latest-${ARCH}
							'''
						}
					}
					stage('remove-images') {
						steps {
							sh '''
								docker rmi -f $(docker images --filter=reference="${REPO}:*" -q)
								docker rmi -f $(docker images --filter=reference="walkero/amigagccondocker:*" -q)
							'''
						}
					}
				}
				post {
					always {
						sh '''
							docker logout
						'''
					}
				}
			}
		}
		stage('create-manifest') {
			when { buildingTag() }
			steps {
				sh '''
					docker manifest create ${REPO}:${BUILD_TAG} ${REPO}:${BUILD_TAG}-amd64 ${REPO}:${BUILD_TAG}-arm64
					docker manifest create ${REPO}:latest ${REPO}:latest-amd64 ${REPO}:latest-arm64
					echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin
					docker manifest push ${REPO}:${BUILD_TAG}
					docker manifest push ${REPO}:latest
					docker logout
				'''
			}
		}
	}
}
