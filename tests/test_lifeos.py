"""End-to-end tests for scripts/lifeos.py. Run: python -m pytest -q"""
from __future__ import annotations

import json
import os
import shutil
import subprocess
import sys
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[1]
CLI = ROOT / "scripts" / "lifeos.py"
TODAY = "2026-10-19"

CSV = """Date,Description,Amount,Balance
10/01/2026,PAYROLL MARGARITAS DIRECT DEP,512.40,900.00
10/02/2026,HANNAFORD #8240 AUBURN ME,-62.18,837.82
10/03/2026,DUNKIN #3355,-6.45,831.37
10/03/2026,DUNKIN #3355,-6.45,824.92
10/06/2026,MYSTERY MERCHANT LLC,-24.00,800.92
Total,,,
"""


def run(*args, cwd=None, check=True):
    env = {**os.environ, "LIFEOS_TODAY": TODAY}
    r = subprocess.run([sys.executable, str(CLI), *args], cwd=cwd, env=env, capture_output=True, text=True)
    if check and r.returncode:
        raise AssertionError(f"lifeos {' '.join(args)} failed:\n{r.stdout}\n{r.stderr}")
    return r


def vrun(vault: Path, *args, check=True):
    env = {**os.environ, "LIFEOS_TODAY": TODAY}
    r = subprocess.run([sys.executable, str(vault / "_system/bin/lifeos.py"), *args], cwd=vault, env=env,
                       capture_output=True, text=True)
    if check and r.returncode:
        raise AssertionError(f"vault lifeos {' '.join(args)} failed:\n{r.stdout}\n{r.stderr}")
    return r


@pytest.fixture()
def vault(tmp_path: Path) -> Path:
    v = tmp_path / "vault"
    run("init", str(v), "--name", "Tester")
    return v


def test_init_creates_structure(vault: Path):
    for p in ["CLAUDE.md", "01 Home.md", "finance/main.beancount", "_system/bin/lifeos.py",
              ".claude/commands/today.md", ".claude/skills/lifeos-finance/SKILL.md",
              ".claude/skills/obsidian-bases/SKILL.md", "_bases/Projects.base", ".lifeos.json"]:
        assert (vault / p).exists(), p
    assert "Tester" in (vault / "CLAUDE.md").read_text()
    assert "{{owner}}" not in (vault / "finance/main.beancount").read_text()


def test_init_refuses_non_empty(tmp_path: Path):
    d = tmp_path / "x"
    d.mkdir()
    (d / "note.md").write_text("hi")
    r = run("init", str(d), check=False)
    assert r.returncode != 0 and "not empty" in r.stderr
    run("init", str(d), "--adopt")
    assert (d / "note.md").read_text() == "hi"
    assert (d / "CLAUDE.md").exists()


def test_empty_ledger_is_valid(vault: Path):
    assert "0 errors" in vrun(vault, "finance", "check").stdout


def test_new_notes(vault: Path):
    assert vrun(vault, "new", "daily").stdout.strip() == f"50 Journal/Daily/{TODAY}.md"
    assert vrun(vault, "new", "weekly").stdout.strip() == "50 Journal/Weekly/2026-W43.md"
    out = vrun(vault, "new", "course", "ACC 120 Financial Accounting").stdout.strip()
    text = (vault / out).read_text()
    assert text.startswith("---\ntype: course") and "# ACC 120 Financial Accounting" in text
    # idempotent
    assert vrun(vault, "new", "daily").stdout.strip() == f"50 Journal/Daily/{TODAY}.md"


def test_lint_finds_overdue_dead_links_and_skips_journal_nav(vault: Path):
    vrun(vault, "new", "daily")
    course = vault / vrun(vault, "new", "course", "ACC 120").stdout.strip()
    course.write_text(course.read_text() + "\n- [ ] HW 3 📅 2026-10-15\n- [ ] Exam 📅 2026-10-22\n"
                      "- [x] Quiz 📅 2026-10-01\nSee [[Missing Note]] and `[[ignored]]`\n")
    f = json.loads(vrun(vault, "lint", "--json").stdout)
    assert [i["date"] for i in f["overdue"]] == ["2026-10-15"]
    assert [i["date"] for i in f["due_soon"]] == ["2026-10-22"]
    assert [d["link"] for d in f["dead_links"]] == ["Missing Note"]
    assert f["orphans"] == []


def test_import_categorizes_and_dedupes(vault: Path, tmp_path: Path):
    csv = tmp_path / "checking.csv"
    csv.write_text(CSV)
    out = vrun(vault, "finance", "import", str(csv), "--profile", "checking").stdout
    assert "Added 5 transactions (1 need a category" in out
    out = vrun(vault, "finance", "import", str(csv), "--profile", "checking").stdout
    assert "Added 0 transactions" in out and "skipped 5" in out
    ledger = (vault / "finance/transactions/2026-10.beancount").read_text()
    assert '"Hannaford"' in ledger and "Expenses:Food:Groceries" in ledger
    assert ledger.count("Expenses:Food:Coffee-Snacks") == 2  # two identical same-day purchases kept
    assert "Expenses:Uncategorized" in ledger and "! \"Mystery Merchant Llc\"" in ledger
    assert "1 uncategorized" in vrun(vault, "finance", "check").stdout


def test_report_numbers(vault: Path, tmp_path: Path):
    openpyxl = pytest.importorskip("openpyxl")
    csv = tmp_path / "checking.csv"
    csv.write_text(CSV)
    vrun(vault, "finance", "import", str(csv), "--profile", "checking")
    (vault / "finance/opening.beancount").write_text(
        '2026-09-30 * "Opening balance"\n  Assets:Bank:Checking  387.60 USD\n  Equity:Opening-Balances\n')
    (vault / "finance/budget.toml").write_text('[monthly]\n"Food:Groceries" = 200\n')
    vrun(vault, "finance", "report")
    money = (vault / "20 Areas/Money/Money.md").read_text()
    assert "| Income | $512.40 |" in money
    assert "| Spending | $99.08 |" in money
    assert "| Food:Groceries | $62.18 | $200.00 | $137.82 |" in money
    assert "| Assets:Bank:Checking | $800.92 |" in money
    wb = openpyxl.load_workbook(vault / "finance/reports/Finance 2026.xlsx")
    assert wb.sheetnames == ["Read Me", "Summary", "Transactions", "Budget", "Monthly"]
    assert wb["Transactions"].max_row >= 6
    # second run replaces the block instead of appending another
    vrun(vault, "finance", "report")
    assert (vault / "20 Areas/Money/Money.md").read_text().count("lifeos:finance:start") == 1


@pytest.mark.parametrize("text,blocked", [
    ("card 4111 1111 1111 1111", True),
    ("amex 378282246310005", True),
    ("ssn 123-45-6789", True),
    ("routing number: 011000015", True),
    ("password = hunter2hunter2", True),
    ("Visa ending 4417, phone 207-555-1234", False),
    ("2026-10-01 2026-10-02 2026-10-03", False),
    ('  import-id: "64c693c77ff2a30f"\n  Assets:Bank:Checking  512.40 USD', False),
])
def test_scan(tmp_path: Path, text: str, blocked: bool):
    f = tmp_path / "f.md"
    f.write_text(text)
    assert (run("scan", str(f), check=False).returncode != 0) == blocked


@pytest.mark.skipif(shutil.which("git") is None, reason="git not installed")
def test_precommit_hook_blocks_secrets(vault: Path):
    g = ["git", "-C", str(vault)]
    subprocess.run([*g, "init", "-q"], check=True)
    subprocess.run([*g, "config", "user.email", "t@example.com"], check=True)
    subprocess.run([*g, "config", "user.name", "T"], check=True)
    run("sync", "--vault", str(vault))  # sets core.hooksPath now that .git exists
    subprocess.run([*g, "add", "-A"], check=True)
    assert subprocess.run([*g, "commit", "-qm", "init"]).returncode == 0
    (vault / "00 Inbox" / "oops.md").write_text("my card 4111 1111 1111 1111")
    subprocess.run([*g, "add", "-A"], check=True)
    r = subprocess.run([*g, "commit", "-qm", "oops"], capture_output=True, text=True)
    assert r.returncode != 0 and "card number" in r.stderr
    # raw bank exports are ignored entirely
    (vault / "finance/imports/raw/bank.csv").write_text("x")
    status = subprocess.run([*g, "status", "--porcelain"], capture_output=True, text=True).stdout
    assert "bank.csv" not in status
