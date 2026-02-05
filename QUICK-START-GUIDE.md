# Quick Start Guide - 4 Steps to Submission

**Current Status:** 95% complete - infrastructure ready  
**Remaining Time:** 4-5 hours of execution  
**Deadline:** Feb 8, 12:00 PM PST (60+ hours remaining)  

---

## ⚡ Fast Track (4 Steps)

### Step 1: Fund Wallets (15 min) ⏱️

**Agent A:** `0x36dF5D06BF6fcF370BA07eB600427f790986999E`  
**Agent B:** `0xC379Bf86Cd7B79A5C8c98E8E05fe06498C5b18Ed`

```bash
# 1. Base Sepolia ETH
open https://www.base.org/faucet
# Request for BOTH addresses

# 2. USDC for Agent A only
open https://faucet.circle.com/
# Select "Base Sepolia", paste Agent A address

# 3. Verify
open https://sepolia.basescan.org/address/0x36dF5D06BF6fcF370BA07eB600427f790986999E
```

✅ **Done when:** Both addresses have ETH, Agent A has USDC

---

### Step 2: Test on Testnet (30 min) ⏱️

```bash
cd projects/usdc-hackathon-submission

# Terminal 1 - Start Agent B
npm run agent-b

# Terminal 2 - Test all services
npm run agent-a -- fetch https://api.coinbase.com/v2/exchange-rates?currency=ETH
npm run agent-a -- compute sum 100,200,300,400,500
npm run agent-a -- generate "futuristic AI marketplace"
```

**Document in `TESTNET-RESULTS.md`:**
- [ ] 3 transaction hashes
- [ ] Screenshots of output
- [ ] BaseScan links

✅ **Done when:** All 3 services execute, payments verified on BaseScan

---

### Step 3: Push to GitHub (10 min) ⏱️

```bash
cd projects/usdc-hackathon-submission

# Create repo (pick one method):

# Method A: GitHub CLI
gh repo create reflectt/openclaw-usdc-hackathon-2026 \
  --public \
  --description "Agent-to-Agent USDC Payments Demo - OpenClaw USDC Hackathon 2026" \
  --source=. \
  --remote=origin

# Method B: Manual
# 1. Go to https://github.com/new
# 2. Name: openclaw-usdc-hackathon-2026
# 3. Owner: reflectt
# 4. Public, NO initialization
# 5. Create

# Then push
git push -u origin main

# Configure on GitHub:
# - Add topics: blockchain, usdc, base, x402, agent-to-agent, ai-agents
# - Set description
# - Verify README renders with images
```

✅ **Done when:** Repo is public, README displays correctly

---

### Step 4: Demo Video + Submit (3 hours) ⏱️

**Record (follow `DEMO-VIDEO-SCRIPT.md`):**
- 2-3 minute screen recording
- Show full payment flow
- Verify on BaseScan
- Show GitHub repo

**Upload:**
- YouTube (unlisted or public)
- Add link to README.md

**Submit:**
- Update `SUBMISSION.md` with all URLs
- Fill out hackathon submission form
- Include: GitHub URL, video URL, transaction hashes

✅ **Done when:** Submission confirmed, all links working

---

## 📋 Pre-Flight Checklist

**Before starting:**
- [ ] `npm run build` succeeds (should already work)
- [ ] `.env` file exists with wallet keys
- [ ] Both terminals ready
- [ ] Screen recording software installed
- [ ] GitHub account logged in

**Files to reference:**
- `TESTNET-WALLETS.md` - Detailed wallet/funding guide
- `GITHUB-PUSH-INSTRUCTIONS.md` - Detailed repo setup
- `DEMO-VIDEO-SCRIPT.md` - Full video script with timing

---

## 🎯 Expected Results

### Testnet Output (Agent A)
```
✓ Wallet initialized: 0x36dF5D06BF6fcF370BA07eB600427f790986999E
✓ Network: Base Sepolia (testnet)
💰 Wallet ready for transactions

🔍 Discovering services from Agent B...
✓ Found agent: Agent Beta
✓ Services available: 3

📤 Requesting task: fetch
💳 Payment required - processing...
✓ Payment sent: 0xABC123...
✓ Task completed successfully

Result: {...}
```

### Testnet Output (Agent B)
```
╔════════════════════════════════════════════════╗
║  Agent Beta - Service Provider Agent           ║
╚════════════════════════════════════════════════╝

💰 Payment recipient: 0xC379Bf86Cd7B79A5C8c98E8E05fe06498C5b18Ed
✓ x402 resource server initialized
✓ Server listening on http://localhost:3001

📥 Received fetch request...
✓ Payment verified from: {...}
✓ Payment settled successfully
   Fetching: https://api.coinbase.com/...
✓ Task completed successfully
```

---

## 🐛 Common Issues

### "Insufficient funds"
→ Fund wallets from faucets (Step 1)

### "Connection refused"
→ Make sure Agent B is running first

### "Payment verification failed"
→ Check RPC URL: `https://sepolia.base.org`

### GitHub: "Permission denied"
→ Use HTTPS: `https://github.com/USERNAME/REPO.git`

### Images don't show on GitHub
→ Wait 1-2 minutes (GitHub caches aggressively)

---

## ⏱️ Time Budget

| Task | Estimated | Cumulative |
|------|-----------|------------|
| Fund wallets | 15 min | 15 min |
| Run tests | 30 min | 45 min |
| Push to GitHub | 10 min | 55 min |
| Record video | 2 hours | 3h |
| Edit & upload | 30 min | 3.5h |
| Final submission | 1 hour | 4.5h |

**Total:** ~4.5 hours  
**Available:** 60+ hours  
**Buffer:** PLENTY! 😎

---

## 🚀 Launch Commands

**Everything in one place:**

```bash
# Navigate to project
cd /Users/ryan/.openclaw/workspace/projects/usdc-hackathon-submission

# Build (should already work)
npm run build

# Terminal 1: Start Agent B
npm run agent-b

# Terminal 2: Run tests
npm run agent-a -- fetch https://api.coinbase.com/v2/exchange-rates?currency=ETH
npm run agent-a -- compute sum 100,200,300,400,500
npm run agent-a -- generate "futuristic AI marketplace"

# Push to GitHub
git remote add origin git@github.com:reflectt/openclaw-usdc-hackathon-2026.git
git push -u origin main
```

---

## 🎉 Success Indicators

You're done when:
- ✅ All 3 services execute successfully
- ✅ Payments verified on BaseScan
- ✅ GitHub repo is public and looks good
- ✅ Demo video uploaded
- ✅ Submission form completed
- ✅ All URLs working

**Then:** Celebrate! 🎊 You've built a working agent-to-agent payment system!

---

## 📞 Need Help?

**Detailed guides available:**
- `PHASE2-SUBAGENT-COMPLETION.md` - Full completion report
- `TESTNET-WALLETS.md` - Wallet setup details
- `GITHUB-PUSH-INSTRUCTIONS.md` - Repo creation details
- `DEMO-VIDEO-SCRIPT.md` - Video recording guide
- `TESTNET-VALIDATION.md` - Testing procedures

**Everything is documented. You've got this!** 💪

---

**Status:** Ready to execute  
**Confidence:** 98%  
**Blockers:** None  
**Next:** Fund wallets and start testing!
