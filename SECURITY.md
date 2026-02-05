# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |

## Reporting a Vulnerability

If you discover a security vulnerability, please email:

**team@reflectt.ai**

Please do NOT open a public issue.

We'll respond within 48 hours and work with you to address the issue.

## Security Considerations

⚠️ **This is a TESTNET demo** using Base Sepolia and testnet USDC.

### For Production Use

If you plan to use this code in production:

1. **Never commit private keys** - Use environment variables or secret managers
2. **Use hardware wallets** - For production wallets holding real funds
3. **Implement rate limiting** - Prevent payment spam
4. **Add escrow logic** - For trustless transactions
5. **Conduct security audit** - Review all smart contract interactions
6. **Monitor transactions** - Set up alerts for unusual activity
7. **Implement access controls** - Whitelist/blacklist addresses
8. **Test thoroughly** - On testnet with realistic scenarios

## Known Limitations

- No built-in refund mechanism
- No dispute resolution
- No reputation system
- Single-signature transactions only
- No payment batching

These are acceptable for a hackathon demo but should be addressed for production.
