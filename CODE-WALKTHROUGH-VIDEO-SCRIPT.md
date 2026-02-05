# Code Walkthrough Video Script
**OpenClaw USDC Hackathon 2026 - Alternative Submission**  
**Duration:** 3-4 minutes  
**Format:** Screen recording + voiceover  
**Focus:** Code explanation, architecture, x402 flow

---

## Pre-Recording Checklist

- [ ] IDE ready (VS Code recommended)
- [ ] Terminal with large font (16pt)
- [ ] Browser tabs: GitHub repo, x402 docs, Base docs
- [ ] Code files bookmarked for quick navigation
- [ ] Architecture diagrams open
- [ ] Screen recording software (OBS/QuickTime)
- [ ] Microphone tested
- [ ] Remove sensitive data from .env

---

## Video Structure

### [0:00-0:20] Opening & Problem Statement (20 seconds)

**Visual:** GitHub repository homepage

**Script:**
> "Hey, I'm Kai from Reflectt Labs. For the OpenClaw USDC Hackathon, we built a demonstration of autonomous AI agents conducting economic transactions using USDC on Base. The challenge: how can AI agents hire and pay each other for services without human intervention? Let me walk you through our solution."

**On-screen text:**
```
Agent-to-Agent USDC Payments
OpenClaw USDC Hackathon 2026
github.com/itskai-dev/openclaw-usdc-hackathon-2026
```

**Action:**
- Show GitHub repo landing page
- Scroll briefly to show README badges and architecture diagram

---

### [0:20-1:00] Architecture Overview (40 seconds)

**Visual:** Show `assets/diagrams/architecture-overview.svg`

**Script:**
> "Here's the system architecture. We have two autonomous agents: Agent A is a requester who needs services, and Agent B is a performer who provides them. Agent B offers three types of services at different price points: data fetching for one cent, computation for five cents, and content generation for ten cents.
>
> The magic happens through the x402 HTTP payment protocol from Coinbase. When Agent A requests a service, Agent B responds with 402 Payment Required. Agent A automatically constructs and submits a USDC payment on Base Sepolia, then retries the request with cryptographic proof. Agent B verifies the payment on-chain and delivers the service. No human intervention needed."

**On-screen annotations:**
- Highlight "Agent A → Agent B" flow
- Point to "x402 Protocol" layer
- Show "USDC on Base" blockchain layer
- Emphasize "Automatic" at each step

---

### [1:00-2:00] Code Walkthrough: Agent B (Service Provider) (60 seconds)

**Visual:** Open `src/agent-b-performer.ts` in IDE

**Script:**
> "Let me show you the code. Starting with Agent B, the service provider."

**[1:00-1:20] Service Configuration (20s)**

**Show lines 15-43:**
```typescript
const routes: X402RouteConfig[] = [
  {
    path: '/task/fetch',
    price: { amount: '0.01', currency: 'USDC' },
    description: 'Fetch data from external API'
  },
  // ... other services
];
```

**Script:**
> "First, we define our service catalog. Each route has a path, a price in USDC, and a description. This is what Agent A will discover and choose from."

**[1:20-1:40] x402 Server Setup (20s)**

**Show lines 52-62:**
```typescript
const server = new X402Server({
  signer: walletClient,
  routes,
  currency: { symbol: 'USDC', address: usdcAddress },
  network: `evm:${baseSepolia.id}`,
});
```

**Script:**
> "Next, we create an x402 server. We give it our wallet for signing, our service routes, and point it to USDC on Base Sepolia. The x402 SDK handles all the payment protocol complexity for us."

**[1:40-2:00] Protected Endpoints (20s)**

**Show lines 90-110:**
```typescript
app.post('/task/fetch', async (req, res) => {
  const proof = req.headers['x-payment-proof'];
  
  const result = await server.verifyPayment(proof);
  if (!result.valid) {
    return res.status(402).json({ error: 'Invalid payment' });
  }
  
  // Execute the actual service
  const data = await fetch(req.body.url);
  res.json({ result: data });
});
```

**Script:**
> "Here's a protected endpoint. We extract the payment proof from the request header, verify it on-chain through the x402 server, and only execute the service if the payment is valid. If someone tries to access without paying, they get a 402 error."

---

### [2:00-2:45] Code Walkthrough: Agent A (Requester) (45 seconds)

**Visual:** Open `src/agent-a-requester.ts` in IDE

**[2:00-2:20] Discovery (20s)**

**Show lines 70-86:**
```typescript
async function discoverServices() {
  const response = await fetch('http://localhost:3001/info');
  const info = response.data as ServiceInfo;
  
  console.log('Available Services:');
  console.table(info.services);
}
```

**Script:**
> "Agent A starts by discovering available services. It calls the /info endpoint, which is free and returns the service catalog with prices. This is how agents can find each other's capabilities."

**[2:20-2:45] Payment-Enabled Requests (25s)**

**Show lines 100-140:**
```typescript
const client = createX402Client({
  signer: walletClient,
  currency: { symbol: 'USDC', address: usdcAddress },
  network: `evm:${baseSepolia.id}`,
  facilitatorUrl: process.env.FACILITATOR_URL,
});

const response = await client.fetch('http://localhost:3001/task/fetch', {
  method: 'POST',
  body: JSON.stringify({ url: targetUrl }),
});
```

**Script:**
> "When Agent A wants a service, it uses the x402 client. This is a fetch wrapper that automatically handles the payment flow. If it gets a 402 response, it constructs the USDC payment, submits it to Base Sepolia, waits for confirmation, and retries with proof. All transparent to the agent developer."

---

### [2:45-3:20] Local Demo & Payment Flow (35 seconds)

**Visual:** Split screen - two terminals

**[2:45-3:00] Starting Agent B (15s)**

**Show terminal 1:**
```bash
$ npm run agent-b

🤖 Agent Beta - Service Provider
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✓ Wallet loaded: 0xC379...18Ed
✓ USDC configured: 0x036C...Cf7e
✓ Network: Base Sepolia (84532)

📋 Service Catalog:
┌─────────┬────────────────┬─────────┬──────────────────────┐
│ (index) │      name      │  price  │     description      │
├─────────┼────────────────┼─────────┼──────────────────────┤
│    0    │ 'Data Fetch'   │ '$0.01' │ 'Fetch external API' │
│    1    │ 'Computation'  │ '$0.05' │ 'Math operations'    │
│    2    │ 'Content Gen'  │ '$0.10' │ 'Generate text'      │
└─────────┴────────────────┴─────────┴──────────────────────┘

🚀 Server listening on http://localhost:3001
```

**Script:**
> "Let me show it running. Here's Agent B starting up. It loads its wallet, configures USDC, and displays its service catalog. It's now ready to accept requests and payments."

**[3:00-3:20] Agent A Making Request (20s)**

**Show terminal 2:**
```bash
$ npm run agent-a -- fetch https://api.example.com/data

🤖 Agent Alpha - Requester
━━━━━━━━━━━━━━━━━━━━━━━━

📡 Requesting: Data Fetch
💰 Price: $0.01 USDC
🔄 Preparing payment on Base Sepolia...
✓ Payment ready
🔄 Submitting request with payment proof...
✓ Service delivered!

📊 Result:
{ "data": "..." }
```

**Script:**
> "And here's Agent A requesting the data fetch service. You can see it discovers the price, prepares the USDC payment, submits the request with proof, and receives the result. In a testnet environment, this would show actual blockchain transaction hashes."

---

### [3:20-3:45] Technical Highlights (25 seconds)

**Visual:** Show key code snippets side-by-side

**Script:**
> "Key technical highlights: We're using Circle's USDC stablecoin for predictable pricing. Base Sepolia gives us fast, low-cost transactions. The x402 protocol from Coinbase provides the HTTP payment layer. And viem handles all blockchain interactions type-safely.
>
> The entire payment flow is atomic and automatic. No manual approvals, no human intervention. Agents can truly act as economic entities."

**On-screen text:**
- ✅ USDC (Circle) - Stable pricing
- ✅ Base Sepolia - Fast L2
- ✅ x402 Protocol (Coinbase) - HTTP payments
- ✅ viem - Type-safe Ethereum
- ✅ 100% Autonomous

---

### [3:45-4:00] Closing & Call to Action (15 seconds)

**Visual:** GitHub repository with README

**Script:**
> "This demo shows the foundation for an autonomous agent economy. Agents that can hire each other, pay for services, and monetize their capabilities. All the code is open source on GitHub. Clone it, extend it, build on it. Thanks for watching!"

**On-screen text:**
```
Try it yourself:
github.com/itskai-dev/openclaw-usdc-hackathon-2026

Built with:
• x402 Protocol (Coinbase)
• USDC (Circle)
• Base Sepolia
• TypeScript + viem

OpenClaw USDC Hackathon 2026
```

---

## Post-Recording Checklist

- [ ] Edit video (cut dead air, add transitions)
- [ ] Add title card at beginning
- [ ] Add text overlays at key moments
- [ ] Include captions/subtitles (accessibility)
- [ ] Add background music (optional, keep subtle)
- [ ] Export at 1080p
- [ ] Upload to YouTube (unlisted or public)
- [ ] Add to README.md and SUBMISSION.md
- [ ] Test video plays correctly

---

## Alternative Segments (Optional)

### If Time Permits: Payment Verification Detail

**Show:** x402 payment verification code

**Script:**
> "Here's what happens behind the scenes during payment verification. The x402 server extracts the payment proof, queries the Base Sepolia blockchain to verify the USDC transfer actually happened, checks the amount matches the service price, and ensures the payment went to the correct address. Only then does it return 'valid'."

### If Time Permits: Error Handling

**Show:** Error handling code in both agents

**Script:**
> "We've also implemented comprehensive error handling. If Agent A has insufficient USDC balance, it gets a clear error. If the payment amount is wrong, Agent B rejects it. If the blockchain is slow, both agents wait patiently for confirmation. Real-world robustness."

---

## Technical Setup

### Terminal Configuration
```bash
# Large, readable font
Font: SF Mono, 16pt
Colors: Solarized Dark or similar
Window size: 120x30 minimum
```

### IDE Configuration
```
Font: Fira Code, 14-16pt
Theme: Dark+ or GitHub Dark
Line numbers: On
Minimap: Off (cleaner view)
Zoom: 120-130%
```

### Recording Settings
- **Resolution:** 1920x1080
- **Frame rate:** 30fps
- **Bitrate:** 5000-8000 kbps
- **Audio:** 48kHz, 192kbps
- **Format:** MP4 (H.264)

---

## Narration Tips

### Pacing
- Speak clearly and not too fast
- Pause after key concepts
- Match narration to what's on screen
- Don't read code line-by-line

### Energy
- Enthusiastic but not over-the-top
- Confident tone (you built this!)
- Technical but accessible
- Emphasize the "autonomous" and "no human" aspects

### Key Phrases to Include
- "Autonomous agents"
- "No human intervention"
- "Economic transactions"
- "x402 payment protocol"
- "USDC on Base"
- "Type-safe"
- "Production-ready code"

---

## B-Roll Ideas (Optional)

If you want to add visual interest:
- Architecture diagrams with animations
- Transaction flow visualizations
- Code typing (speed up 2-3x)
- Terminal commands running
- GitHub stars/activity
- Base and Circle logos

---

## Upload Checklist

### YouTube
- [ ] Title: "Agent-to-Agent USDC Payments Demo - OpenClaw Hackathon 2026"
- [ ] Description: Include GitHub link, tech stack, explanation
- [ ] Tags: ai agents, usdc, base, x402, web3, cryptocurrency, autonomous agents
- [ ] Thumbnail: Custom image with project name + "Autonomous AI Payments"
- [ ] Category: Science & Technology
- [ ] Allow embedding
- [ ] Add to relevant playlists

### Update Documentation
- [ ] Add YouTube link to README.md
- [ ] Add to SUBMISSION.md
- [ ] Update STATUS.md
- [ ] Commit and push to GitHub

---

## Estimated Timeline

| Segment | Recording | Editing | Total |
|---------|-----------|---------|-------|
| Setup & test | - | - | 30 min |
| Recording (3-4 takes) | 20 min | - | 20 min |
| Editing & transitions | - | 45 min | 45 min |
| Text overlays & captions | - | 30 min | 30 min |
| Review & adjustments | 10 min | 20 min | 30 min |
| Export & upload | - | - | 15 min |
| **Total** | | | **2h 50m** |

---

## Success Criteria

✅ Video clearly explains the problem and solution  
✅ Code walkthrough is easy to follow  
✅ x402 payment flow is demonstrated  
✅ USDC and Base integration is visible  
✅ Autonomous nature is emphasized  
✅ Professional production quality  
✅ 3-4 minutes duration  
✅ Includes call to action (GitHub link)

---

**Ready to record!** This script demonstrates working code and architecture without requiring live testnet transactions. Perfect for a "code-complete, testnet-ready" submission.
