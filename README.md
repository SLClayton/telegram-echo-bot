
# Serverless AWS Telegram Echo Bot

This project demonstrates the barebones code and infrastrucutre needed to create a basic serverless, event-driven, Telegram echo bot on AWS. 

It is written in Python, and is deployed/managed using Terraform.

## Pre-requisits

### Bot Token
You will need to setup a telegram bot and obtain its bot token, instructions can be found on the telegram website

https://core.telegram.org/bots/tutorial#obtain-your-bot-token

### AWS CLI
An authenticated AWS CLI session is required to build AWS resources using terraform. To download AWS CLI and login, follow the tutorials linked.

Install: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

Sign in: https://docs.aws.amazon.com/signin/latest/userguide/command-line-sign-in.html

### Terraform
Installing terraform may differ slightly depending on your OS: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

### Python
This project was built using python 3.10. However it should work with any most modern versions of python 3. If you use a different version ensure to edit the lambda resource in main.tf to match the version you're using to avoid issues.

Tutorial on how to install python based on your OS: https://realpython.com/installing-python/

## Setup

Clone the repo

```
git clone https://github.com/SLClayton/telegram-echo-bot.git
```

Go to the terraform directory

```
cd telegram-echo-bot/terraform
```

Initialise the terraform project

```
terraform init
```

Apply the terraform project, it will ask you to input your bot token, and then will ask you to confirm the deployment by typing 'yes'.

```
terraform apply
```

Add your bot on telegram using the username you created with the Botfather, and send it a message.

![Untitled](https://github.com/user-attachments/assets/0b836dc3-9863-4613-8ce9-00a8241fba79)
<img src="https://github.com/user-attachments/assets/0b836dc3-9863-4613-8ce9-00a8241fba79" width="300">

