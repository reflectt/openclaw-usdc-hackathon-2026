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
