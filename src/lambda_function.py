import json
import os


from telegram import TelegramChat


def lambda_handler(event, context):

    # Extract the chat id and message from body
    request_body = json.loads(event["body"])
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
        "isBase64Encoded": False,
    }
