# Assetto Corsa EVO Server (Docker)

Run Assetto Corsa EVO Dedicated Server in Docker using Wine.

---

## Features

- Wine-based server
- Auto restart on crash
- Headless (no GUI)
- Unraid compatible
- Log output for external dashboards

---

## Setup (Unraid)

### 1. Download server files

Install via Steam:

Steam → Library → Tools → **Assetto Corsa EVO Dedicated Server**

---

### 2. Copy server files

Copy **ALL files** into: /mnt/user/appdata/assettocorsaevo/server

---

### 3. Configure server

In the official launcher click **"Copy Command"** and paste it into: 

/mnt/user/appdata/assettocorsaevo/server_args.txt

---

### 4. Start container

Start the container from Unraid UI.

---

### 5. Updating the Server

This container does NOT include any game server files.

You must update the server manually via Steam:

1. Update the "Assetto Corsa EVO Dedicated Server" in Steam
2. Copy updated files into `/config/server`
3. Restart the container

A new version of this Docker container is NOT required for game updates.

---

## File Structure

```
/config
├── server/            # Server files from Steam
├── logs/
│   └── server.log     # Live server log
└── server_args.txt    # Config from launcher
```

---

## Logs

Server log is available at: /config/logs/server.log

This can be used for external tools like dashboards or leaderboards.

---

## Ports

⚠️ Ports must match values inside your server config

- 9700 TCP
- 9700 UDP

⚠️ When running multiple servers:

- Each container must use a different port
- Port must match inside server_args.txt

---

## Notes

- Server configuration is managed entirely via the official launcher
- This container does not include server files
- You must provide your own files from Steam
