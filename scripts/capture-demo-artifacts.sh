#!/usr/bin/env bash
set -euo pipefail

# capture-demo-artifacts.sh
#
# Goal: generate reproducible “demo artifacts” for the hackathon submission:
# - Export SVG diagrams to PNG (for easy embedding + annotation)
# - Generate a deterministic terminal transcript (commands + sample output)
#
# We intentionally avoid adding new dependencies. If no SVG->PNG converter is
# available, we print a manual fallback.

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DIAGRAMS_DIR="$ROOT_DIR/assets/diagrams"
TERMINAL_DIR="$ROOT_DIR/assets/terminal"

mkdir -p "$DIAGRAMS_DIR" "$TERMINAL_DIR"

say() { printf "%s\n" "$*"; }

convert_svg_to_png() {
  local svg="$1"
  local png="$2"

  if command -v rsvg-convert >/dev/null 2>&1; then
    # rsvg-convert (librsvg) is fast + commonly available on macOS via brew.
    rsvg-convert -w 2000 -h 1200 -o "$png" "$svg"
    return 0
  fi

  if command -v inkscape >/dev/null 2>&1; then
    # Inkscape CLI export
    inkscape "$svg" --export-type=png --export-filename="$png" --export-width=2000
    return 0
  fi

  # No converter found
  return 1
}

say "== Capture Demo Artifacts =="
say "Repo: $ROOT_DIR"

# 1) Export diagrams
say ""
say "[1/2] Exporting diagrams (SVG -> PNG)"

svgs=(
  "$DIAGRAMS_DIR/architecture-overview.svg"
  "$DIAGRAMS_DIR/payment-flow.svg"
)

for svg in "${svgs[@]}"; do
  if [[ ! -f "$svg" ]]; then
    say "  - Missing: $svg (skipping)"
    continue
  fi

  base="$(basename "$svg" .svg)"
  png="$DIAGRAMS_DIR/${base}.png"

  if convert_svg_to_png "$svg" "$png"; then
    say "  - Wrote: assets/diagrams/${base}.png"
  else
    say "  - Could not convert $svg (no rsvg-convert/inkscape found)."
    say "    Manual fallback: open the SVG and export as PNG."
    say "      macOS: open -a Safari \"$svg\"  (then File -> Export / screenshot)"
    say "      Or install: brew install librsvg (provides rsvg-convert)"
  fi

done

# 2) Deterministic terminal transcript
say ""
say "[2/2] Writing deterministic terminal transcript"
TRANSCRIPT="$TERMINAL_DIR/demo-transcript.md"

cat > "$TRANSCRIPT" <<'EOF'
# Demo terminal transcript (deterministic)

This file is **intentionally static** so reviewers (and future-you) have a
consistent reference for the CLI flow **even if testnet faucets are unavailable**.

Use it as:
- a “what the terminal should look like” reference
- a source of copy/paste blocks for screenshots / README

> Source of truth for the full screenshot runbook:
> - `LOCAL-DEMO-SCREENSHOT-PLAN.md`

---

## Terminal 1 — Agent B (service provider)

Command:

```bash
cd projects/usdc-hackathon-submission
npm run agent-b
```

Expected output (sample):

```text
🤖 Agent Beta - Service Provider
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Configuration
✓ Wallet loaded: 0xC379...18Ed
✓ USDC contract: 0x036C...Cf7e
✓ Network: Base Sepolia (84532)
✓ Facilitator: https://x402.coinbase.com/v1

📋 Service Catalog
┌─────────┬──────────────────┬─────────┬───────────────────────┐
│ (index) │       name       │  price  │      description      │
├─────────┼──────────────────┼─────────┼───────────────────────┤
│    0    │ 'Data Fetch'     │ '$0.01' │ 'Fetch external API'  │
│    1    │ 'Computation'    │ '$0.05' │ 'Compute results'     │
│    2    │ 'Content Gen'    │ '$0.10' │ 'Generate content'    │
└─────────┴──────────────────┴─────────┴───────────────────────┘

🚀 x402 Payment Server
   Listening on: http://localhost:3001
   Ready to accept paid requests!
```

---

## Terminal 2 — Agent A discovery (no payment)

Command:

```bash
cd projects/usdc-hackathon-submission
npm run agent-a -- discover
```

Expected output (sample):

```text
🤖 Agent Alpha - Service Requester
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔍 Discovering services from Agent Beta...
   Endpoint: http://localhost:3001/info

✓ Connected to Agent: Agent Beta
✓ Available services: 3

📋 Service Details
┌─────────┬──────────────────┬─────────┬───────────────────────┐
│ (index) │       name       │  price  │      description      │
├─────────┼──────────────────┼─────────┼───────────────────────┤
│    0    │ 'Data Fetch'     │ '$0.01' │ 'Fetch external API'  │
│    1    │ 'Computation'    │ '$0.05' │ 'Compute results'     │
│    2    │ 'Content Gen'    │ '$0.10' │ 'Generate content'    │
└─────────┴──────────────────┴─────────┴───────────────────────┘

💡 Tip: Use these services with:
   npm run agent-a -- fetch <url>
   npm run agent-a -- compute <operation> <numbers>
   npm run agent-a -- generate <prompt>
```

---

## Optional — full demo (requires wallet funding / testnet reliability)

Command:

```bash
npm run agent-a -- demo
```

Notes:
- This may fail if you can't access faucets / the RPC is rate-limited.
- For hackathon submission, **code-walkthrough mode is acceptable**: show the
  diagrams + routes + x402 integration + the discovery output.
EOF

say "  - Wrote: assets/terminal/demo-transcript.md"

say ""
say "Done."
say "Next: capture screenshots into assets/screenshots/ (see PLACEHOLDERS.md + LOCAL-DEMO-SCREENSHOT-PLAN.md)"
