---
type: data
status: active
tldr: Q1 2026 chatbot resolution funnel — 38% of conversations exit at intent classification (highest exit point), only 41% resolve autonomously
---

# Data: Chatbot Resolution Funnel — Q1 2026

**Source:** Metabase dashboard — Chatbot Resolution Funnel (all conversations)
**Captured:** 2026-04-01
**Freshness:** Valid until 2026-07-01 (re-pull quarterly)
**Sample:** 12,400 conversations (Jan–Mar 2026)

---

## Funnel breakdown

| Step | Conversations reaching step | Exit rate | Note |
|---|---|---|---|
| 1 — Conversation started | 12,400 | 8% | Spam / greetings / immediate opt-out |
| 2 — Intent classified | 11,408 | **38%** | ⚠️ Primary failure point |
| 3 — Response generated | 7,073 | 14% | Response irrelevant or incomplete |
| 4 — User satisfied (no follow-up) | 6,082 | 5% | Minor dissatisfaction |
| **Autonomous resolution** | **5,084** | — | **41% of all conversations** |

**Key finding:** Intent classification (step 2) is the single largest exit point — 2.7x higher than any other step. Of the 4,335 conversations that exit at step 2, 92% escalate to human agents.

---

## Segmentation

| Segment | Resolution rate | Notes |
|---|---|---|
| English | 47% | Baseline for improvement target |
| Portuguese | 9% | Near-zero — [[opportunities/multilingual-coverage-gap]] |
| Spanish | 11% | Near-zero — [[opportunities/multilingual-coverage-gap]] |
| Enterprise tier | 43% | Slightly below average |
| SMB tier | 40% | Roughly equivalent |
| Mobile (app) | 38% | Below average — possible separate opportunity |

---

**Informs:**
- [[opportunities/intent-classification-gap]] — step 2 exit rate
- [[opportunities/multilingual-coverage-gap]] — Portuguese/Spanish resolution rates
- [[solutions/prd-intent-classifier-v2]] — defines success baseline

**What this data doesn't tell us:** whether step 2 exits are due to wrong classification, missing intents, or edge cases like very short/ambiguous messages. Needs LLM-based audit of misclassified conversations to break down root causes.
