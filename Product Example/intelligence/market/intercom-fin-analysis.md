---
type: market
status: active
tldr: Intercom Fin uses GPT-4 for intent understanding with no rule-based layer — claims 45%+ resolution rates, positions on "understands natural language" vs Acme's structured commands approach
---

# Market: Intercom Fin — Competitive Analysis

**Captured:** 2026-03-20
**Source:** Intercom website, G2 reviews, product demos (3 demos attended by Bruno Lima)

---

## What they're doing

Intercom Fin is their AI-first support agent, launched in late 2023. Core differentiator: no rule-based intent layer. They use GPT-4 directly with a custom prompt that includes the entire knowledge base as context. The model classifies intent AND generates the response in one call.

**Architecture (inferred from docs + demos):**
1. User message → GPT-4 with KB context in system prompt
2. Model decides: answer directly OR escalate with a reason
3. If escalated, human agent receives the LLM's summary of what the user needs

**Claimed resolution rate:** "Over 45%" in their marketing. G2 reviews suggest 40–55% range depending on KB quality.

**Positioning:** "Understands natural language, not commands" — a direct shot at rule-based chatbots like Acme's current architecture.

---

## Implications for Acme

- Fin's approach validates our direction in [[solutions/prd-intent-classifier-v2]] — LLM-based classification is the right architectural bet
- Their weakness: GPT-4 in the hot path adds latency. Several G2 reviews mention "slow responses." This is our opportunity if we can build LLM-quality classification at lower latency (GPT-4o-mini fine-tuned may outperform generic GPT-4 on our domain)
- They don't offer multilingual support for Portuguese. No competitive threat in LATAM in the short term.

---

## What this doesn't tell us

- We don't have Fin's internal resolution rate data broken down by intent category — would need customer interviews with joint Intercom/Acme customers
- We don't know their fine-tuning approach, if any
- Pricing comparison: Fin charges per resolution ($0.99/resolution), Acme charges per seat — different model, hard to compare directly

**Related:** [[opportunities/intent-classification-gap]], [[solutions/prd-intent-classifier-v2]]
