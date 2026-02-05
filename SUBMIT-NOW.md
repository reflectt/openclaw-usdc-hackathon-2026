# SUBMIT-NOW (Hackathon submission one-pager)

This page is the **final checklist + copy/paste fields** for the OpenClaw USDC Hackathon 2026 submission.

If you only have 10 minutes, do this in order:
1) Fill in the **Final Links** section
2) Capture/upload screenshots (or skip optional ones)
3) Record the code walkthrough video (or paste link)
4) Submit the form using the **Copy/Paste Form Fields** section

---

## Final Links (fill these in)

- **Repo:** https://github.com/reflectt/openclaw-usdc-hackathon-2026
- **Release (optional but recommended):** <PASTE_GITHUB_RELEASE_URL>
- **Demo / code walkthrough video:** <PASTE_VIDEO_URL>
- **Submission confirmation / public page (after submit):** <PASTE_URL_IF_ANY>

---

## Screenshots checklist (upload into repo first)

Folder: `assets/screenshots/`

Follow the detailed plan:
- `LOCAL-DEMO-SCREENSHOT-PLAN.md`

Required filenames (recommended set):
- [ ] `01-agent-b-startup.png`
- [ ] `02-agent-a-discovery.png`
- [ ] `03-code-agent-b-routes.png`
- [ ] `04-code-x402-server.png`
- [ ] `05-code-agent-a-client.png`
- [ ] `06-architecture-annotated.png`
- [ ] `07-payment-flow-annotated.png`
- [ ] `08-npm-scripts.png`
- [ ] `09-documentation-overview.png`
- [ ] `10-github-repo.png`

When done:
- [ ] Embed key screenshots into `README.md` (copy/paste snippet is at the bottom of `LOCAL-DEMO-SCREENSHOT-PLAN.md`)

---

## Video checklist (Ryan-owned, but keep it here)

Primary script:
- `CODE-WALKTHROUGH-VIDEO-SCRIPT.md`

Backup demo script (if you end up doing a live run):
- `DEMO-VIDEO-SCRIPT.md`

Video requirements (recommended):
- [ ] 5–10 minutes total
- [ ] Show the diagrams briefly (architecture + payment flow)
- [ ] Show the code (Agent B routes + x402 server + Agent A client)
- [ ] Show the CLI UX (`npm run agent-a -- discover` etc.)

---

## "Copy/paste" form fields

> Adjust labels to match the official hackathon form.

### Project
- **Project name:** Agent-to-Agent USDC Payments Demo
- **One-liner:** Autonomous agents buy/sell API services using USDC via Coinbase x402 (HTTP 402 → pay → verify → deliver).

### Links
- **Repository URL:** https://github.com/reflectt/openclaw-usdc-hackathon-2026
- **Video URL:** <PASTE_VIDEO_URL>
- **Release URL (if asked):** <PASTE_GITHUB_RELEASE_URL>

### Description (long)
Paste:

```text
This project demonstrates agent-to-agent economic transactions where an AI agent can discover services offered by another agent, pay for them in USDC, and receive the result only after on-chain payment verification.

We use Coinbase's x402 protocol (HTTP 402 Payment Required) with Circle USDC on Base Sepolia. Agent B exposes three paid endpoints (fetch, compute, generate) and protects them with x402 middleware. Agent A uses an x402-enabled fetch client that automatically handles 402 challenges, executes USDC payment, and retries with proof.

The repo includes architecture diagrams, a clear walkthrough script, a local screenshot plan, and a submission one-pager to make review fast.
```

### Track / tech keywords (if asked)
- **Keywords:** USDC, x402, Base Sepolia, micropayments, agent economy, HTTP 402, Express, TypeScript

### Team
- Reflectt Labs (AI Agent Team)

---

## Final sanity checks (2 minutes)

- [ ] `README.md` has working links + updated video URL
- [ ] `assets/screenshots/` populated and committed
- [ ] No secrets committed (`.env` should never be committed; scan recent commits if needed)
- [ ] (Optional) Create GitHub Release using `RELEASE.md`

---

## Where everything lives

- Submission one-pager: `SUBMIT-NOW.md`
- Submission guide: `SUBMISSION.md`
- Submission checklist: `SUBMISSION-CHECKLIST.md`
- Screenshot plan: `LOCAL-DEMO-SCREENSHOT-PLAN.md`
- Video script: `CODE-WALKTHROUGH-VIDEO-SCRIPT.md`
- Quick start: `START-HERE.md` and `QUICK-START-GUIDE.md`
