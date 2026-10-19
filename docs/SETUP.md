# Setup

## Windows: the fast way (about 10 minutes)

1. Open **Terminal** (or PowerShell) from the Start menu. Don't run it as admin.
2. Paste this line and press Enter:

   ```
   irm https://raw.githubusercontent.com/mitakihari/lifeos/main/scripts/setup-windows.ps1 | iex
   ```

3. Approve any Windows install prompts. When a GitHub sign-in window appears, sign in. That's how Git reaches your private vault.

The script installs Git, Python, GitHub Desktop, and Obsidian. It downloads both repos to `C:\Users\<you>\LifeOS\`, then installs the Python packages, wires up the vault, and runs a health check. It's safe to run again anytime; it skips anything already done. Then jump to **step 5** below.

## Manual setup (Mac, Linux, or if the script fails)

This takes about 30 minutes, once. No Git knowledge is needed. GitHub Desktop handles it.

You'll end up with two folders side by side:

```
LifeOS/
├── lifeos/          the tools (public repo)
└── lifeos-vault/    your notes and money (PRIVATE repo)
```

> **Commands below:** on Windows, type `python`. On Mac and Linux, type `python3`. Run them in a terminal (Windows: "Terminal" or "PowerShell").

## 1. Install the apps

| App | Why | Get it |
|---|---|---|
| **GitHub Desktop** | Downloads and syncs your repos, no commands needed | desktop.github.com |
| **Git** | Lets Obsidian Git auto-backup the vault | git-scm.com/downloads (accept the defaults) |
| **Python 3.11+** | Runs the LifeOS CLI and the books | python.org/downloads. **On Windows, tick "Add python.exe to PATH".** |
| **Obsidian** | The app you read and write the vault in | obsidian.md |
| **Claude Code** *(optional but recommended)* | Lets Claude run the commands and scripts directly | claude.com/claude-code |

Linux: install `git` and `python3-pip` from your package manager. Obsidian and GitHub Desktop are available as AppImage or Flatpak.

## 2. Get the repos onto your computer

1. Open **GitHub Desktop**, then go to **File → Options → Accounts → Sign in** to GitHub.
2. Go to **File → Clone repository**, pick `lifeos`, and set the local path to `LifeOS/lifeos`.
3. Do the same for `lifeos-vault`, into `LifeOS/lifeos-vault`.

## 3. Install the Python pieces

In a terminal:

```
cd LifeOS/lifeos
python -m pip install -r requirements.txt
```

## 4. Wire up the vault (run this once per computer)

```
python scripts/lifeos.py sync --vault ../lifeos-vault
cd ../lifeos-vault
python _system/bin/lifeos.py plugins install
python _system/bin/lifeos.py doctor
```

`sync` turns on the secret-scan safety hook. That setting lives on your computer, not in the repo, which is why this step runs once per machine. `doctor` should show everything as `[ok]`.

## 5. Open it in Obsidian

1. Open Obsidian, choose **Open folder as vault**, and pick `lifeos-vault`.
2. If it asks about **Restricted mode**, turn it off. That's what enables the plugins (Tasks, Obsidian Git, Calendar).
3. Go to **Settings → Core plugins** and make sure **Templates**, **Daily notes**, and **Bases** are on.
4. Open `01 Home.md`.

**Obsidian Git** now backs up the vault to your private GitHub repo every 15 minutes. The first time it pushes, Git may pop up a browser window to sign in to GitHub. That's normal.

## 6. Talk to Claude

**Claude Code (recommended):** open a terminal in `lifeos-vault` and run `claude`. It reads `CLAUDE.md` automatically. Type `/kickoff` for the first session.

**Claude app:** create a Project and paste in [CLAUDE-APP-PROJECT.md](CLAUDE-APP-PROJECT.md). In each chat, use **+ → Add folder** to add `lifeos-vault`.

## Day to day

| When | Do |
|---|---|
| Every morning | `/today` |
| When you download bank statements | Save the CSVs in `lifeos-vault/finance/imports/raw/`, then `/money` |
| Sunday | `/weekly` |
| The 1st of the month | `/monthly` |
| A new class, job posting, or apartment | `/class`, `/job`, `/apartment` |

## Updating the tools later

In GitHub Desktop, select `lifeos` and click **Fetch / Pull**. Then:

```
python scripts/lifeos.py sync --vault ../lifeos-vault
```

## If something breaks

- **First,** run `python _system/bin/lifeos.py doctor` from the vault. It tells you what to fix.
- **A commit gets blocked by the secret scan:** it found something that looks like a card or account number. Replace it with the last 4 digits and commit again.
- **The ledger has errors:** run `python _system/bin/lifeos.py finance check`. It gives the file and line number. Or ask Claude to run `/lint`.
