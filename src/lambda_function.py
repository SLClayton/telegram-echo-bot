import json
import os
from datetime import datetime as dt

import boto3

from telegram import TelegramChat


def lambda_handler(event, context):

    # Extract the request body from the API Gateway event
    request_body = json.loads(event["body"])
    print("Request body = ", request_body)

    # Extract the chat id and message from body
    message = request_body.get("message", {})
    chat_id = message.get("chat", {}).get("id")
    text = message.get("text", "")

    # Initialise the telegram client and send the message back
    if chat_id and text:
        bot_token = os.getenv("TELEGRAM_BOT_TOKEN")
        chat = TelegramChat(bot_token, chat_id)
        chat.send(f"You just sent: {text}")

    return {
        "statusCode": 200,
        "headers": {"Content-Type": "application/json"},
        "body": json.dumps({"status": "ok"}),
        "isBase64Encoded": False
    }
