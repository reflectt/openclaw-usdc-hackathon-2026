# Release Checklist (GitHub)

This repo is a hackathon submission. The goal of this file is to make it **copy/paste easy** to cut a clean GitHub Release when you're ready.

## Suggested tag / version

- **Tag:** `v1.0.0-usdc-hackathon`
- **Release title:** `OpenClaw USDC Hackathon 2026 — v1.0.0`

(If you prefer a plain semver tag, use `v1.0.0` and keep the same release title.)

---

## Pre-flight

- [ ] Repo is public (if required by the hackathon)
- [ ] `npm install` succeeds
- [ ] `npm run build` succeeds
- [ ] `npm test` succeeds (optional if blocked by wallets/faucets)
- [ ] `.env` contains **no secrets committed** (verify `.gitignore` is working)

## Docs / submission assets

- [ ] Update `README.md` **Demo Video** link (or Code Walkthrough link)
- [ ] Populate `assets/screenshots/` with the required screenshots
  - Follow: `LOCAL-DEMO-SCREENSHOT-PLAN.md`
- [ ] Confirm `SUBMIT-NOW.md` has final links filled in:
  - [ ] Repo URL
  - [ ] Video URL
  - [ ] Screenshot list completed

## Git state

- [ ] `git status` is clean
- [ ] All important docs are committed (scripts, checklists, guides)

## Create the Release

### Option A — GitHub UI

1. GitHub → **Releases** → **Draft a new release**
2. Tag: `v1.0.0-usdc-hackathon`
3. Target: `main`
4. Title: `OpenClaw USDC Hackathon 2026 — v1.0.0`
5. Description (paste this):

```text
Agent-to-agent USDC payments demo using Coinbase x402 on Base Sepolia.

Highlights:
- Agent A discovers and pays Agent B for services over HTTP using x402 (402 Payment Required → pay → retry with proof)
- Three paid services: fetch ($0.01), compute ($0.05), generate ($0.10)
- Clear docs, diagrams, and scripts for a fast walkthrough

Start here:
- README.md
- SUBMIT-NOW.md
```

### Option B — CLI

```bash
git tag v1.0.0-usdc-hackathon
git push origin v1.0.0-usdc-hackathon
```

Then draft the release in GitHub UI and paste the description above.
