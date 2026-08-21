# DailyXP API Agent Contract

Canonical product ticket: https://github.com/da5ater/dailyxp/issues/27 (API-001)
Product PRD: https://github.com/da5ater/dailyxp/blob/main/docs/design/dailyxp-v1.md at 4382b7bcc2b2553cdac15a9c43eed9dfab084d9d

Agents own research, design, implementation, verification, ticket context, and PR review. Mohamed owns product decisions, approval, and final merge.

## Working agreement

- One implementation ticket active at a time, branch -> draft PR -> implementation -> simplify -> review -> fix -> merge (only Mohamed says `merge`).
- Every ticket records fixed and usage-sensitive cost at current, 100-user, 1,000-user, cheaper alternatives, chosen value, caps, observed cost, portability.
- No AWS charge-capable provisioning without Mohamed explicit approval. Prefer Free Tier, budgets/alerts, zero-cost local path.
- AWS adapters must not enter domain logic; domain tests must not require AWS SDK.
