---
type: outcome
status: active
confidence: high
explored: false
tldr: Increase chatbot autonomous resolution rate from 41% to 60% by end of Q2-2026, reducing support costs and improving CX
---

# Outcome: Increase Autonomous Resolution Rate — Q2 2026

**OKR:** Increase chatbot autonomous resolution rate from 41% → 60% by 2026-06-30.

**Why this matters:** Acme's support costs grew 34% YoY while the team headcount grew only 12%. The gap is widened by chatbot failures that escalate to human agents — 59% of all conversations today. If the chatbot resolves 60% autonomously, we avoid hiring 8 additional agents and improve P90 response time from 4.2min to under 1min.

**Key results:**
- KR1: Chatbot autonomous resolution rate ≥ 60% (measured weekly via [[intelligence/data/resolution-rate-baseline]])
- KR2: Human escalation rate ≤ 40% (from current 59%)
- KR3: P90 first-response time ≤ 60 seconds for resolved tickets

**Strategic context:** This OKR feeds into the company-level goal of reaching $0.80 cost-per-ticket (currently $2.10). Approved at Q2 planning with full exec alignment.

**Opportunities contributing to this outcome:**
- [[opportunities/intent-classification-gap]] — most impactful gap (accounts for ~60% of failed resolutions)
- [[opportunities/multilingual-coverage-gap]] — secondary gap (15% of escalations from LATAM customers)

**Decisions made in service of this outcome:**
- [[intelligence/decisions/prioritize-intent-over-multilingual]] — Q2 bet on intent first

**Experiments tracking progress:**
- [[experiments/intent-classifier-v2-ab]]
