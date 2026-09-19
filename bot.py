import os
import discord
from discord.ext import tasks

TOKEN = os.environ["DISCORD_TOKEN"]
CHANNEL_ID = int(os.environ["CHANNEL_ID"])

intents = discord.Intents.default()
client = discord.Client(intents=intents)


@client.event
async def on_ready():
    print(f"Logged in as {client.user}")
    print("Auto-clear system started.")

    if not clear_channel.is_running():
        clear_channel.start()


@tasks.loop(minutes=10)
async def clear_channel():
    channel = client.get_channel(CHANNEL_ID)

    if channel is None:
        print("Could not find the channel.")
        return

    try:
        deleted = await channel.purge(limit=None)

        print(
            f"Deleted {len(deleted)} messages "
            f"from #{channel.name}"
        )

    except discord.Forbidden:
        print("ERROR: The bot needs Manage Messages permission.")

    except discord.HTTPException as e:
        print(f"Discord API error: {e}")


@clear_channel.before_loop
async def before_clear():
    await client.wait_until_ready()


client.run(TOKEN)