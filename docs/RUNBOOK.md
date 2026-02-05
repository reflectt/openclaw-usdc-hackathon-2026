# Runbook (Ops)

This project is a hackathon/demo app that simulates **agent-to-agent USDC payments** (x402 protocol). This runbook covers the minimum operational steps for running the demo and basic troubleshooting.

## Service / Components

- **Agent A (requester)**: initiates a request and expects a paid response.
- **Agent B (performer)**: receives the request and completes work after payment.
- **Chain**: Base Sepolia (demo/testnet).

## Pre-flight checklist

1. **Node version**: use Node >= 18.
2. **Install deps**:
   ```bash
   npm ci
   ```
3. **Environment variables**:
   - Copy `.env.example` → `.env` and fill values.
   - Never commit `.env`.

## Run the demo

```bash
npm run demo
```

If you prefer separate terminals:

```bash
# Terminal 1
npm run agent-b

# Terminal 2
npm run agent-a
```

## Common failure modes

### Build fails

```bash
npm run build
```

- Ensure TypeScript is installed (via devDependencies)
- Ensure you are on a supported Node version

### Missing env vars

Symptoms:
- Errors mentioning missing private keys / RPC URLs
- Runtime errors in wallet setup

Fix:
- Re-check `.env` and compare against `.env.example`

### Testnet funding issues

Symptoms:
- Transactions fail or remain pending

Fix:
- Ensure the Base Sepolia wallet(s) are funded and the RPC endpoint is healthy.
- See `TESTNET-WALLETS.md` / `WALLET-FUNDING-GUIDE.md`.

## Incident response (lightweight)

If this were running as a long-lived service, the minimum incident loop:

1. **Identify**: capture error output + what command was run.
2. **Assess**: is it env/config vs chain/RPC vs code?
3. **Mitigate**: retry with known-good RPC, verify wallet balances, re-run setup.
4. **Document**: add a short note to this runbook if it’s a new class of failure.
