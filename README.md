# Discord Auto-Clear Bot

A small Discord bot that automatically clears every message from one Discord channel every 10 minutes.

## What it does

- Connects to Discord using `discord.py`
- Clears the configured channel every 10 minutes
- Runs as a macOS LaunchAgent in the background
- Starts automatically when you log into your Mac
- Restarts automatically if the bot crashes
- Does not require a Terminal window to stay open

## Setup on macOS

### 1. Install Python dependencies

From this folder:

```bash
python3 -m pip install -r requirements.txt
```

### 2. Create your local `.env`

```bash
cp .env.example .env
nano .env
```

Set:

```text
DISCORD_TOKEN=your_bot_token
CHANNEL_ID=your_channel_id
```

Never commit `.env` to GitHub. It is ignored by `.gitignore`.

### 3. Test the bot

```bash
chmod +x run.sh
./run.sh
```

If it connects successfully, press `Ctrl+C` to stop the test.

### 4. Install automatic background startup

```bash
chmod +x install-autostart.sh
./install-autostart.sh
```

The bot will run through the macOS LaunchAgent:

`com.user.discordclear`

You can check it with:

```bash
launchctl print gui/$(id -u)/com.user.discordclear
```

Check logs with:

```bash
cat out.log
cat err.log
```

You can also verify the Python process with:

```bash
ps aux | grep "[b]ot.py"
```

## Restarting the bot

```bash
launchctl kickstart -k gui/$(id -u)/com.user.discordclear
```

## Stopping the bot

```bash
launchctl bootout gui/$(id -u) ~/Library/LaunchAgents/com.user.discordclear.plist
```

## Keeping a MacBook awake with the lid closed

macOS normally sleeps when a MacBook is closed. If you intentionally want the Mac to stay awake while running this bot, you can use:

```bash
sudo pmset -a disablesleep 1
```

Check the setting with:

```bash
pmset -g
```

This keeps the Mac awake, so use it carefully: keep the Mac plugged in and well ventilated, and do not leave it running closed inside a bag or other enclosed space.

To restore normal sleep behavior:

```bash
sudo pmset -a disablesleep 0
```

## Discord permissions

The bot needs the appropriate permissions to manage messages in the target channel, including **Manage Messages**.

## Render

`render.yaml` is included as an optional deployment configuration, but the project can run locally on a Mac without Render.
