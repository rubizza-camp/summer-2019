README about TelegramBot

1. The main functionality of TelegramBot - checkin and checkout of Rubizza SPB Students.
2. Stack: Redis, Ruby, Telegram API
3. Bot have geolocation check. If student isn't at Rubizza Camp - he won't checkin/checkout.
4. All status key for Bot is storing in Redis
5. Main commands: /start, /checkin, /checkout, /developer/status
/start - main command for working with bot. When you push /start - you start telegram loop and your main session.
/checkin - When you push checkin, you will go through 3 steps(photo,geolocation validation,geolocation) and
after that your data will be stored in PostgreSQL.
Every checkin/checkout have a timestamp. You can see when student checks at camp.
/checkout - When you push checkin, you will go through 3 steps(photo,geolocation validation,geolocation)
/developer/status - in every cycle of loop you can check what status for your session is keeping Redis.
