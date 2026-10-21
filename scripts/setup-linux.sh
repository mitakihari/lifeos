#!/usr/bin/env bash
# LifeOS one-shot setup for Linux (Arch/CachyOS/Manjaro, Debian/Ubuntu/Mint, Fedora).
#   curl -fsSL https://raw.githubusercontent.com/mitakihari/lifeos/main/scripts/setup-linux.sh | bash
# Safe to re-run: installed packages are skipped, existing clones are updated.
#
# What it does:
#   1. installs git, python, GitHub CLI (gh) and Obsidian with your package manager
#   2. signs Git into GitHub through `gh auth login` (browser), so the private vault can sync
#   3. clones lifeos + lifeos-vault into ~/LifeOS
#   4. creates a Python virtualenv at ~/LifeOS/.venv for beancount/fava/openpyxl
#      (Arch and newer Debian block `pip install --user` into the system Python)
#   5. wires up the vault and installs a `lifeos` command in ~/.local/bin
#
# Env overrides (mostly for testing): LIFEOS_ROOT, LIFEOS_OWNER, LIFEOS_GIT_BASE, LIFEOS_SKIP_PACKAGES=1, LIFEOS_SKIP_AUTH=1

set -euo pipefail

OWNER="${LIFEOS_OWNER:-mitakihari}"
ROOT="${LIFEOS_ROOT:-$HOME/LifeOS}"
GIT_BASE="${LIFEOS_GIT_BASE:-https://github.com/$OWNER}"
TOOLKIT="$ROOT/lifeos"
VAULT="$ROOT/lifeos-vault"
VENV="$ROOT/.venv"

step() { printf '\n\033[36m==> %s\033[0m\n' "$*"; }
have() { command -v "$1" >/dev/null 2>&1; }
die()  { printf '\033[31merror: %s\033[0m\n' "$*" >&2; exit 1; }

# ---------------------------------------------------------------------------
step "1/6 Installing packages (git, python, GitHub CLI, Obsidian). You may be asked for your sudo password."
if [ "${LIFEOS_SKIP_PACKAGES:-0}" != 1 ]; then
  # Don't install a second Obsidian if one already exists (pacman, AUR, Flatpak or AppImage).
  obsidian_present=0
  if have obsidian || { have flatpak && flatpak info md.obsidian.Obsidian >/dev/null 2>&1; } \
     || ls "$HOME"/Applications/*bsidian*.AppImage "$HOME"/*bsidian*.AppImage "$HOME"/.local/bin/*bsidian* >/dev/null 2>&1; then
    obsidian_present=1; echo "  Obsidian already installed, leaving it alone"
  fi
  if have pacman; then
    need=()
    pkgs=(git python python-pip github-cli); [ "$obsidian_present" = 1 ] || pkgs+=(obsidian)
    for p in "${pkgs[@]}"; do pacman -Qq "$p" >/dev/null 2>&1 || need+=("$p"); done
    [ ${#need[@]} -eq 0 ] && echo "  all installed" || sudo pacman -S --needed --noconfirm "${need[@]}"
  elif have apt-get; then
    sudo apt-get update -qq
    sudo apt-get install -y -qq git python3 python3-venv python3-pip gh flatpak
    [ "$obsidian_present" = 1 ] || flatpak info md.obsidian.Obsidian >/dev/null 2>&1 || {
      flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
      flatpak install --user -y flathub md.obsidian.Obsidian
    }
  elif have dnf; then
    sudo dnf install -y -q git python3 python3-pip gh flatpak
    [ "$obsidian_present" = 1 ] || flatpak info md.obsidian.Obsidian >/dev/null 2>&1 || {
      flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
      flatpak install --user -y flathub md.obsidian.Obsidian
    }
  else
    die "unsupported package manager. Install git, python 3.11+, gh and Obsidian yourself, then re-run with LIFEOS_SKIP_PACKAGES=1"
  fi
fi

PY=""
for c in python3 python; do
  if have "$c" && "$c" -c 'import sys; sys.exit(sys.version_info < (3, 11))' 2>/dev/null; then PY="$(command -v "$c")"; break; fi
done
[ -n "$PY" ] || die "Python 3.11+ not found"
echo "  python: $PY ($("$PY" --version 2>&1))"

# ---------------------------------------------------------------------------
step "2/6 Git identity and GitHub sign-in"
git config --global user.name  >/dev/null || git config --global user.name "Fox Barnett"
git config --global user.email >/dev/null || git config --global user.email "$OWNER@users.noreply.github.com"
git config --global core.autocrlf input
echo "  $(git config --global user.name) <$(git config --global user.email)>"
if [ "${LIFEOS_SKIP_AUTH:-0}" != 1 ]; then
  if ! gh auth status >/dev/null 2>&1; then
    echo "  A browser window will open: sign in to GitHub as $OWNER and enter the code shown here."
    gh auth login --hostname github.com --git-protocol https --web
  else
    echo "  already signed in to GitHub"
  fi
  gh auth setup-git   # lets plain `git` (and Obsidian Git) use the gh login
fi

# ---------------------------------------------------------------------------
step "3/6 Downloading your repos into $ROOT"
mkdir -p "$ROOT"
for name in lifeos lifeos-vault; do
  dir="$ROOT/$name"
  if [ -d "$dir/.git" ]; then
    echo "  $name exists, pulling updates"; git -C "$dir" pull --ff-only
  else
    git clone "$GIT_BASE/$name.git" "$dir"
  fi
done

# ---------------------------------------------------------------------------
step "4/6 Python packages (Beancount, Fava, openpyxl) in $VENV"
[ -x "$VENV/bin/python" ] || "$PY" -m venv "$VENV"
"$VENV/bin/python" -m pip install --quiet --upgrade pip
"$VENV/bin/python" -m pip install --quiet -r "$TOOLKIT/requirements.txt"

# ---------------------------------------------------------------------------
step "5/6 Wiring up the vault and installing the \`lifeos\` command"
"$VENV/bin/python" "$TOOLKIT/scripts/lifeos.py" sync --vault "$VAULT"
"$VENV/bin/python" "$VAULT/_system/bin/lifeos.py" plugins install --vault "$VAULT"
mkdir -p "$HOME/.local/bin"
cat > "$HOME/.local/bin/lifeos" <<EOF
#!/bin/sh
# LifeOS CLI. Runs the vault's copy with the LifeOS virtualenv. Created by setup-linux.sh.
exec "$VENV/bin/python" "$VAULT/_system/bin/lifeos.py" --vault "$VAULT" "\$@"
EOF
chmod +x "$HOME/.local/bin/lifeos"
case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) echo "  note: add ~/.local/bin to your PATH to use the \`lifeos\` command (fish: fish_add_path ~/.local/bin)";; esac

# ---------------------------------------------------------------------------
step "6/6 Health check"
"$HOME/.local/bin/lifeos" doctor

printf '\n\033[32mDone. Your vault is at: %s\033[0m\n' "$VAULT"
printf '\033[32mNext: open Obsidian -> "Open folder as vault" -> pick that folder, and trust its plugins.\033[0m\n'
printf '\033[32mFrom any terminal: lifeos lint | lifeos new daily | lifeos finance report | lifeos finance fava\033[0m\n'
