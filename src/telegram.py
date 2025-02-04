import requests


class TelegramChat:

    def __init__(self, token: str, chat_id: int):
        self.base_url = f"https://api.telegram.org/bot{token}"
        self.chat_id = chat_id

    def send(self, text: str) -> None:
        resp = requests.post(
            url=f"{self.base_url}/sendMessage", 
            json={"chat_id": self.chat_id, "text": text}
        )
        resp.raise_for_status()
