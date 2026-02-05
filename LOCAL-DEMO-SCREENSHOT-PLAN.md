# Local Demo Screenshot Plan
**Alternative to Testnet Validation**  
**Focus:** Code demonstration, architecture, and working local implementation

---

## Screenshot Requirements

All screenshots should be:
- **Resolution:** 1920x1080 or higher
- **Format:** PNG (better quality than JPEG)
- **Font size:** Terminal 16pt minimum, IDE 14pt minimum
- **Clean:** Remove personal info, clear terminal history
- **Annotated:** Add arrows/highlights where helpful

---

## Screenshot 1: Agent B Startup & Service Catalog

**File:** `assets/screenshots/agent-b-startup.png`  
**Purpose:** Show the service provider's initialization and catalog

**Setup:**
```bash
cd projects/usdc-hackathon-submission
npm run agent-b
```

**Capture when you see:**
```
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

**What this shows:**
- Agent B successfully initializes
- Service catalog with 3 services
- Prices in USDC
- x402 server running

**Optional annotations:**
- Arrow pointing to service prices → "USDC micropayments"
- Highlight wallet address → "Base Sepolia wallet"
- Circle the table → "Agent-discoverable services"

---

## Screenshot 2: Agent A Service Discovery

**File:** `assets/screenshots/agent-a-discovery.png`  
**Purpose:** Show Agent A discovering Agent B's services

**Setup:**
```bash
# Terminal 2 (keep Agent B running)
npm run agent-a -- discover
```

**Capture output:**
```
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

**What this shows:**
- Agent A can discover Agent B's services
- Free discovery endpoint (no payment needed)
- Structured service information

**Optional annotations:**
- Highlight "3 services discovered"
- Note "No payment required for discovery"

---

## Screenshot 3: Code View - Agent B Service Definition

**File:** `assets/screenshots/code-agent-b-routes.png`  
**Purpose:** Show the service route configuration

**Setup:**
- Open `src/agent-b-performer.ts` in VS Code
- Navigate to lines 15-50 (route definitions)
- Zoom to 130-140%

**Capture showing:**
```typescript
const routes: X402RouteConfig[] = [
  {
    path: '/task/fetch',
    method: 'POST',
    price: {
      amount: '0.01',
      currency: 'USDC'
    },
    description: 'Fetch data from external API',
    handler: async (req) => {
      const url = req.body.url;
      const response = await fetch(url);
      const data = await response.json();
      return { success: true, data };
    }
  },
  {
    path: '/task/compute',
    method: 'POST',
    price: {
      amount: '0.05',
      currency: 'USDC'
    },
    description: 'Perform mathematical computation',
    handler: async (req) => {
      // ... computation logic
    }
  },
  // ... more routes
];
```

**What this shows:**
- Clean service definition structure
- USDC pricing configuration
- Handler functions for each service
- x402 route configuration

**Optional annotations:**
- Highlight price amounts → "USDC micropayments"
- Arrow to handler → "Service logic"

---

## Screenshot 4: Code View - x402 Server Setup

**File:** `assets/screenshots/code-x402-server.png`  
**Purpose:** Show x402 server initialization

**Capture from `src/agent-b-performer.ts` (lines 52-70):**
```typescript
// Initialize x402 payment server
const server = new X402Server({
  signer: walletClient,
  routes,
  currency: {
    symbol: 'USDC',
    address: usdcAddress,
    decimals: 6
  },
  network: `evm:${baseSepolia.id}` as `${string}:${string}`,
  facilitatorUrl: process.env.FACILITATOR_URL || 'https://x402.coinbase.com/v1',
});

// Create Express middleware
const paymentMiddleware = createX402Middleware(server);

// Apply to protected routes
app.use('/task/*', paymentMiddleware);
```

**What this shows:**
- x402 SDK integration
- USDC and Base Sepolia configuration
- Payment middleware protecting routes

**Optional annotations:**
- Highlight X402Server → "Coinbase x402 SDK"
- Point to currency config → "Circle USDC"
- Note middleware → "Payment-protected endpoints"

---

## Screenshot 5: Code View - Agent A Payment Client

**File:** `assets/screenshots/code-agent-a-client.png`  
**Purpose:** Show automatic payment handling

**Capture from `src/agent-a-requester.ts` (lines 100-140):**
```typescript
// Create payment-enabled HTTP client
const client = createX402Client({
  signer: walletClient,
  currency: {
    symbol: 'USDC',
    address: usdcAddress,
    decimals: 6
  },
  network: `evm:${baseSepolia.id}` as `${string}:${string}`,
  facilitatorUrl: process.env.FACILITATOR_URL,
});

// Make payment-enabled request
async function requestService(url: string, body: any) {
  console.log('🔄 Sending request with automatic payment...');
  
  const response = await client.fetch(url, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(body),
  });
  
  console.log('✓ Payment verified, service delivered!');
  return response.json();
}
```

**What this shows:**
- x402 client creation
- Automatic payment flow handling
- No manual payment logic needed

**Optional annotations:**
- Highlight createX402Client → "Automatic payment wrapper"
- Note fetch call → "Transparent payment handling"

---

## Screenshot 6: Architecture Diagram (Annotated)

**File:** `assets/screenshots/architecture-annotated.png`  
**Purpose:** Clear visual of the full system

**Setup:**
- Open `assets/diagrams/architecture-overview.svg` in browser
- Take high-resolution screenshot
- Add annotations in an image editor (or export from diagram tool)

**Annotations to add:**
1. **Agent A box:** "Requester (wants services)"
2. **Agent B box:** "Performer (provides services)"
3. **x402 arrow:** "HTTP 402 Payment Required"
4. **Blockchain:** "USDC transfer on Base Sepolia"
5. **Return arrow:** "Service delivered after payment"

**Color coding (optional):**
- Discovery flow: Blue
- Payment flow: Green
- Service delivery: Purple

---

## Screenshot 7: Payment Flow Sequence (Annotated)

**File:** `assets/screenshots/payment-flow-annotated.png`  
**Purpose:** Show step-by-step payment sequence

**Setup:**
- Open `assets/diagrams/payment-flow.svg`
- Take screenshot
- Add step numbers

**Annotations:**
```
1. Agent A → Agent B: "Can I have this service?"
2. Agent B → Agent A: "402 Payment Required - $0.01 USDC"
3. Agent A → Base Sepolia: "Transfer 0.01 USDC to Agent B"
4. Base Sepolia → Agent A: "Transaction confirmed: 0xabc123..."
5. Agent A → Agent B: "Here's proof: 0xabc123..."
6. Agent B → Base Sepolia: "Did they really pay?"
7. Base Sepolia → Agent B: "Yes, verified!"
8. Agent B → Agent A: "Here's your data!"
```

---

## Screenshot 8: Package.json Scripts

**File:** `assets/screenshots/npm-scripts.png`  
**Purpose:** Show easy CLI interface

**Capture from `package.json`:**
```json
"scripts": {
  "build": "tsc",
  "agent-a": "node dist/agent-a-requester.js",
  "agent-b": "node dist/agent-b-performer.js",
  "test": "node dist/test/e2e-test.js",
  "setup": "./scripts/setup.sh"
}
```

**And terminal showing usage:**
```bash
$ npm run agent-a -- --help

Usage: agent-a [command] [options]

Commands:
  discover                Discover available services
  fetch <url>            Fetch data from URL ($0.01)
  compute <op> <nums>    Compute operation ($0.05)
  generate <prompt>      Generate content ($0.10)
  demo                   Run full demo

Options:
  --help                 Show this help message
```

**What this shows:**
- Easy-to-use CLI interface
- Clear command structure
- Professional UX

---

## Screenshot 9: Documentation Quality

**File:** `assets/screenshots/documentation-overview.png`  
**Purpose:** Show comprehensive documentation

**Capture:** VS Code file explorer showing:
```
├── README.md (11KB)
├── QUICKSTART.md (4KB)
├── SUBMISSION.md (9KB)
├── ARCHITECTURE.md (15KB)
├── PAYMENT-FLOW.md (15KB)
├── CODE-WALKTHROUGH-VIDEO-SCRIPT.md (12KB)
├── CONTRIBUTING.md (1KB)
├── SECURITY.md (1KB)
├── docs/
│   ├── ARCHITECTURE.md
│   └── PAYMENT-FLOW.md
├── examples/
│   ├── fetch-data.sh
│   ├── compute.sh
│   └── generate-content.sh
└── assets/
    ├── diagrams/
    └── screenshots/
```

**What this shows:**
- Professional documentation structure
- Multiple guides for different audiences
- Complete submission package

---

## Screenshot 10: GitHub Repository

**File:** `assets/screenshots/github-repo.png`  
**Purpose:** Show public repository with badges and stars

**Capture from:** https://github.com/itskai-dev/openclaw-usdc-hackathon-2026

**Include in view:**
- Repository name and description
- Badges (License, Network, Protocol)
- Topics/tags
- README preview with architecture diagram
- Star/fork/watch buttons

**What this shows:**
- Open source contribution
- Professional presentation
- Community engagement

---

## Optional Screenshot: Type Safety

**File:** `assets/screenshots/typescript-types.png`  
**Purpose:** Show TypeScript type checking

**Capture:** IDE with TypeScript IntelliSense showing:
- Auto-completion for x402 methods
- Type errors prevented
- Interface definitions
- Type-safe blockchain interactions

**What this shows:**
- Production-ready code quality
- Type safety throughout
- Professional development practices

---

## Screenshot Organization

### Directory Structure
```
assets/
├── screenshots/
│   ├── 01-agent-b-startup.png
│   ├── 02-agent-a-discovery.png
│   ├── 03-code-agent-b-routes.png
│   ├── 04-code-x402-server.png
│   ├── 05-code-agent-a-client.png
│   ├── 06-architecture-annotated.png
│   ├── 07-payment-flow-annotated.png
│   ├── 08-npm-scripts.png
│   ├── 09-documentation-overview.png
│   └── 10-github-repo.png
└── diagrams/
    ├── architecture-overview.svg
    └── payment-flow.svg
```

### Naming Convention
- Use numbers for ordering (01, 02, ...)
- Descriptive names (what it shows)
- Lowercase with hyphens
- PNG format

---

## Adding to README

After capturing, update README.md:

```markdown
## 📸 Screenshots

### Agent B (Service Provider)
![Agent B Startup](assets/screenshots/01-agent-b-startup.png)
*Agent B initializing with service catalog and USDC payment configuration*

### Service Discovery
![Agent A Discovery](assets/screenshots/02-agent-a-discovery.png)
*Agent A discovering available services from Agent B*

### Code: Service Routes
![Service Routes](assets/screenshots/03-code-agent-b-routes.png)
*Clean service definition with USDC pricing*

### Code: x402 Integration
![x402 Server](assets/screenshots/04-code-x402-server.png)
*Coinbase x402 SDK integration with Circle USDC on Base Sepolia*

### Code: Payment Client
![Payment Client](assets/screenshots/05-code-agent-a-client.png)
*Automatic payment handling with x402 client*

### Architecture (Annotated)
![Architecture](assets/screenshots/06-architecture-annotated.png)
*Complete system architecture showing agent-to-agent payment flow*

### Payment Sequence
![Payment Flow](assets/screenshots/07-payment-flow-annotated.png)
*Step-by-step payment verification and service delivery*
```

---

## Image Editing Tools

**For annotations:**
- **macOS:** Preview, Pixelmator, Sketch
- **Windows:** Paint, Paint.NET, Photoshop
- **Linux:** GIMP, Krita
- **Online:** Figma, Canva

**Annotation tips:**
- Use arrows sparingly
- Keep text large and readable (18pt+)
- Use consistent colors (green for success, red for errors, blue for info)
- Add drop shadows for readability

---

## Quality Checklist

Before finalizing each screenshot:
- [ ] Resolution 1920x1080 or higher
- [ ] Font size readable (16pt+ terminal, 14pt+ IDE)
- [ ] No personal information visible
- [ ] Clear focus on relevant code/output
- [ ] Annotations helpful but not cluttered
- [ ] Saved as PNG (not JPEG)
- [ ] Optimized file size (<500KB if possible)
- [ ] Descriptive filename

---

## Timeline Estimate

| Task | Time |
|------|------|
| Setup terminals/IDE | 15 min |
| Capture 10 screenshots | 30 min |
| Add annotations | 45 min |
| Update README with embeds | 20 min |
| Review and touch up | 20 min |
| Commit and push | 10 min |
| **Total** | **2h 20m** |

---

## Success Criteria

✅ All key components visible in screenshots  
✅ Code quality demonstrated  
✅ x402 integration clear  
✅ USDC and Base configuration shown  
✅ Professional presentation  
✅ README updated with all screenshots  
✅ Annotations helpful and clear

---

**This screenshot plan demonstrates the working code and architecture without requiring live testnet transactions.** Perfect for a "code-complete, testnet-ready" submission! 📸
