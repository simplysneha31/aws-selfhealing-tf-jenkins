pipeline {
  agent any

  parameters {
    booleanParam(name: 'AUTO_APPLY', defaultValue: false, description: 'Auto-apply Terraform changes?')
    string(name: 'EC2_INSTANCE_ID', description: 'EC2 instance ID to monitor and reboot')
  }

  environment {
    TF_WORKING_DIR = "terraform"
    PATH = "$HOME/bin:$PATH"
  }

  stages {
    stage('Install Tools') {
      steps {
        sh '''
          echo "Checking AWS CLI"
          if ! command -v aws &> /dev/null; then
            echo "AWS CLI not found. Installing..."
            curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
            unzip -q -o awscliv2.zip
            ./aws/install --install-dir ~/my-aws-cli --bin-dir ~/bin --update
          else
            echo "AWS CLI already installed: $(aws --version)"
          fi

          echo "Checking Terraform"
          if command -v terraform &> /dev/null; then
            echo "Terraform already installed: $(terraform version | head -n 1)"
          else
            echo "Terraform not found. Installing"
            curl -fsSL https://releases.hashicorp.com/terraform/1.12.2/terraform_1.12.2_linux_amd64.zip -o terraform.zip
            unzip -o terraform.zip
            mkdir -p $HOME/bin
            mv terraform $HOME/bin/terraform
          fi
        '''
      }
    }

    stage('Terraform Operations') {
      steps {
        withCredentials([
          string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'),
          string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')
        ]) {
          script {
            dir("${TF_WORKING_DIR}") {
              sh 'terraform init'
              sh 'terraform validate'
              sh 'terraform plan -var="ec2_instance_id=${EC2_INSTANCE_ID}" -out=tfplan'
              if (params.AUTO_APPLY) {
                sh 'terraform apply -auto-approve tfplan'
              }
            }
          }
        }
      }
    }
  }

  post {
    success {
      echo "Terraform pipeline completed successfully."
    }
    failure {
      echo "Terraform pipeline failed. Check logs for details."
    }
  }
}
