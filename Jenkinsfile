pipeline {
  agent {
    kubernetes {
      yaml """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: buildah
    image: quay.io/buildah/stable
    command:
    - cat
    tty: true
    securityContext:
      privileged: true
    volumeMounts:
    - name: varlibcontainers
      mountPath: /var/lib/containers
  volumes:
  - name: varlibcontainers
    emptyDir: {}
"""
    }
  }

  environment {
    IMAGE_NAME = "docker.io/SAMIEZEEDE/my-buildah-app:latest"
    DOCKER_CREDENTIALS = credentials('9f69660e-46c1-44c8-ae68-9390d7d1682a')
  }

  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/SAMIEZEEDE/my-buildah-pipeline.git'
      }
    }

    stage('Build Image') {
      steps {
        container('buildah') {
          sh '''
            buildah bud -t $IMAGE_NAME .
            buildah login -u $DOCKER_CREDENTIALS_USR -p $DOCKER_CREDENTIALS_PSW docker.io
            buildah push $IMAGE_NAME
          '''
        }
      }
    }
  }
}
