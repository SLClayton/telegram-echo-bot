
# Serverless AWS Telegram Echo Bot (Python)

This project demonstrates the barebones code and infrastructure needed to create a basic serverless, event-driven, Telegram echo bot on AWS. 

By using Telegram’s webhook approach in a serverless environment, you benefit from an event-driven model, meaning the bot only runs when a new message is 'pushed' from telegram. And there is no need to keep polling the telegram API waiting for new messages. This reduces costs by charging only for actual invocations (rather than a continuously running server).

## How it works

This project utilises Telegram’s webhook functionality to trigger a single AWS Lambda function using its Function URL. Whenever a user sends a message to the bot, Telegram delivers the update to that URL. The Lambda function then uses the Telegram API to send a response back to the sender. The Terraform configuration sets up all required AWS resources (permissions, roles, and the Lambda) and configures the Telegram webhook to point to the Function URL automatically after every deployment using Telegrams's API.

## Pre-requisits

### OS

This project was built on Ubuntu Linux and should work on most modern Linux distributions or macOS without changes. On Windows, you can use the [Windows Subsystem for Linux (WSL)](https://learn.microsoft.com/en-us/windows/wsl/install) for a smoother experience. If you prefer running everything natively on Windows, be aware you may need to make a few minor adjustments.

### Bot Token
You will need to setup a telegram bot and obtain its bot token. 

[Obtain your bot token](https://core.telegram.org/bots/tutorial#obtain-your-bot-token)

### AWS CLI
An authenticated AWS CLI session is required to build AWS resources using terraform. To download AWS CLI and login, follow the tutorials linked.

[Getting Started Install](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[CLI Sign In](https://docs.aws.amazon.com/signin/latest/userguide/command-line-sign-in.html)

### Terraform
[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Python
This project was built using python 3.10. However it should work with most modern versions of python 3. If you use a different version, ensure to edit the lambda resource in main.tf to match the version you're using to avoid issues.

[Tutorial on how to install python](https://realpython.com/installing-python/)

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

Apply the terraform project, it will ask you to input your bot token, and then ask you to confirm the deployment by typing 'yes'.

```
terraform apply
```

You can alternativley setup a [.tfvars file to manage the variables](https://spacelift.io/blog/terraform-tfvars) and input the telegram token there before applying with the file as an argument.

```
terraform apply -var-file=<your-var-filename>.tfvars
```

Add your bot on telegram using the username you created with the Botfather, and send it a message.
<div align="center">
  <img src="https://github.com/user-attachments/assets/0b836dc3-9863-4613-8ce9-00a8241fba79" width="400">
</div>


