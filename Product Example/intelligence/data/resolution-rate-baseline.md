---
type: data
status: active
tldr: Autonomous resolution rate metric definition and Q1 2026 baseline — 41%, measured weekly, target 60% by end of Q2
---

# Metric: Autonomous Resolution Rate — Baseline

**Definition:** Percentage of chatbot conversations that reach resolution without human escalation, measured as: (conversations resolved autonomously) / (total conversations started) × 100.

**Resolution = autonomous** when: no human agent is assigned to the ticket within 24 hours of the conversation ending, and the user does not re-open the conversation within 72 hours.

**Baseline (Q1 2026):** 41%
**Target (Q2 2026):** 60%
**Gap:** 19 percentage points

**Measurement cadence:** Weekly, every Monday
**Data source:** Metabase — Chatbot KPIs dashboard (refreshes Sunday midnight)
**Owner:** Ana Souza (PM)

---

## Historical trend

| Quarter | Resolution rate | Notes |
|---|---|---|
| Q3 2025 | 38% | Pre-new KB articles |
| Q4 2025 | 40% | KB expansion (+200 articles) |
| Q1 2026 | **41%** | Minimal improvement despite KB work |
| Q2 2026 target | **60%** | Intent classifier fix expected to drive this |

The plateau from Q3→Q1 suggests that knowledge base expansion has hit diminishing returns. The bottleneck has shifted from "missing answers" to "can't classify what the user is asking."

---

**Informs:**
- [[outcomes/increase-autonomous-resolution-q2]] — primary KR metric
- [[solutions/prd-intent-classifier-v2]] — success metric baseline
- [[experiments/intent-classifier-v2-ab]] — experiment measurement baseline

**Freshness note:** Baseline confirmed for Q1. Re-pull at Q2 midpoint (2026-05-15) and end of Q2 (2026-06-30).
