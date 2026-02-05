# Screenshot placeholders (exact shot list + fast commands)

This file is a **clipboard-friendly checklist** for capturing the submission screenshots.

Source of truth (more detail + sample outputs):
- `LOCAL-DEMO-SCREENSHOT-PLAN.md`

> Save all images as **PNG** at **1920×1080+**.

---

## 01 — Agent B startup + service catalog

**Filename:** `assets/screenshots/01-agent-b-startup.png`

**Command (Terminal 1):**
```bash
cd projects/usdc-hackathon-submission
npm run agent-b
```

**Capture:** header + config + service catalog table + “Listening on …3001”.

---

## 02 — Agent A discovery

**Filename:** `assets/screenshots/02-agent-a-discovery.png`

**Command (Terminal 2):**
```bash
cd projects/usdc-hackathon-submission
npm run agent-a -- discover
```

**Capture:** “Found agent …” + “Services available: 3” + the 3 service entries.

---

## 03 — Code: Agent B paid routes / pricing

**Filename:** `assets/screenshots/03-code-agent-b-routes.png`

**Open file:** `src/agent-b-performer.ts`

**Fast open (VS Code):**
```bash
cd projects/usdc-hackathon-submission
code -g src/agent-b-performer.ts:1
```

**Capture:** the route definitions showing `/task/*` paths + USDC amounts.

---

## 04 — Code: x402 server setup + middleware

**Filename:** `assets/screenshots/04-code-x402-server.png`

**Open file:** `src/agent-b-performer.ts`

**Fast open (VS Code):**
```bash
cd projects/usdc-hackathon-submission
code -g src/agent-b-performer.ts:1
```

**Capture:** `X402Server(...)` config + middleware application protecting routes.

---

## 05 — Code: Agent A x402 payment client

**Filename:** `assets/screenshots/05-code-agent-a-client.png`

**Open file:** `src/agent-a-requester.ts`

**Fast open (VS Code):**
```bash
cd projects/usdc-hackathon-submission
code -g src/agent-a-requester.ts:1
```

**Capture:** payment-enabled fetch wrapper + paid request call.

---

## 06 — Architecture diagram (annotated)

**Filename:** `assets/screenshots/06-architecture-annotated.png`

**Diagram source:** `assets/diagrams/architecture-overview.svg` (or `.png` after export)

**Fast open (macOS):**
```bash
cd projects/usdc-hackathon-submission
open assets/diagrams/architecture-overview.svg
```

**Tip:** Run the exporter first:
```bash
./scripts/capture-demo-artifacts.sh
```

**Capture:** diagram + your callouts (Agent A, Agent B, HTTP 402, Base Sepolia, USDC).

---

## 07 — Payment flow diagram (annotated)

**Filename:** `assets/screenshots/07-payment-flow-annotated.png`

**Diagram source:** `assets/diagrams/payment-flow.svg` (or `.png` after export)

**Fast open (macOS):**
```bash
cd projects/usdc-hackathon-submission
open assets/diagrams/payment-flow.svg
```

**Capture:** numbered sequence: 402 challenge → USDC payment → proof → verification → delivery.

---

## 08 — npm scripts + CLI usage

**Filename:** `assets/screenshots/08-npm-scripts.png`

**Part A (code):** `package.json` scripts
```bash
cd projects/usdc-hackathon-submission
code package.json
```

**Part B (terminal):** show a discovery run or usage block

- If you can run discovery:
  ```bash
  npm run agent-a -- discover
  ```

- If you need deterministic sample output (for reference):
  - `assets/terminal/demo-transcript.md`

---

## 09 — Documentation overview (file tree)

**Filename:** `assets/screenshots/09-documentation-overview.png`

**Capture:** VS Code explorer showing `README.md`, submission docs, and `assets/`.

**Fast open:**
```bash
cd projects/usdc-hackathon-submission
code .
```

---

## 10 — GitHub repo page

**Filename:** `assets/screenshots/10-github-repo.png`

**URL:** https://github.com/reflectt/openclaw-usdc-hackathon-2026

**Capture:** repo header + badges/topics + README preview showing diagrams.

---

## After screenshots

1) Ensure files are named exactly as above.
2) Commit them.
3) Embed key screenshots into `README.md` (snippet is at bottom of `LOCAL-DEMO-SCREENSHOT-PLAN.md`).
