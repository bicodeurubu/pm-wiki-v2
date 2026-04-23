---
type: solution
status: draft
confidence: medium
explored: false
tldr: Replace rule-based intent classifier with a fine-tuned LLM classifier trained on Acme's resolved tickets — targeting 38% → ≤10% misclassification rate
---

# PRD: Intent Classifier v2

## Problem

[[opportunities/intent-classification-gap]] — the chatbot misclassifies user intent in 38% of conversations, causing unnecessary escalations and failing our Q2 OKR ([[outcomes/increase-autonomous-resolution-q2]]).

The current classifier uses hand-crafted keyword rules. It was built in 2023 with 12 intent categories. Since then, Acme's product surface has grown to 34 features, and the rule set hasn't kept pace. The model has no understanding of context — it matches on first keyword, ignores follow-up messages.

## What we're building

Fine-tune a small LLM (GPT-4o-mini or equivalent) on Acme's historical resolved ticket transcripts. Replace the current rule-based classifier at the intent detection step of the resolution pipeline.

**The new classifier will:**
- Understand full conversation context (not just first message)
- Cover all 34 current product features (vs 12 today)
- Confidence-score each classification — low-confidence cases get a clarifying question instead of a wrong answer
- Degrade gracefully: fall back to the current rules if the LLM call fails

## Success metrics

- Primary: intent misclassification rate ≤ 10% (from 38%) — measured via [[intelligence/data/resolution-rate-baseline]]
- Secondary: autonomous resolution rate ≥ 55% within 4 weeks of full rollout
- Guardrail: P99 latency ≤ 800ms (LLM call must not degrade response time)

## Scope

**In:** English conversations only for Q2 (LATAM expansion is Q3 — see [[opportunities/multilingual-coverage-gap]])
**In:** All 34 intent categories in current product taxonomy
**Out:** Knowledge base content updates (separate team)
**Out:** Sentiment analysis improvements

## Evidence base

- [[intelligence/research/interview-synthesis-q1]] — qualitative validation of intent frustration
- [[intelligence/data/chatbot-funnel-q1]] — quantitative evidence of misclassification rate
- [[intelligence/data/resolution-rate-baseline]] — baseline for success metric
- [[intelligence/decisions/prioritize-intent-over-multilingual]] — decision record
- [[intelligence/market/intercom-fin-analysis]] — competitive context: Fin uses similar approach

## Experiments planned

- [[experiments/intent-classifier-v2-ab]] — primary validation before full rollout

## Open questions

1. Do we fine-tune on all resolved tickets, or only on tickets where the original classification was correct?
2. What's the confidence threshold below which we trigger the clarifying question?
3. Who owns the intent taxonomy going forward — PM or CS ops?

## Change log

| Date | What changed | Why |
|---|---|---|
| 2026-04-10 | Initial draft created | [[intelligence/decisions/prioritize-intent-over-multilingual]] approved |
