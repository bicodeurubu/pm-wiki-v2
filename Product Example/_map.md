# Product Brain — Map (Acme Support AI)

Auto-maintained TLDR index. The LLM reads this before reading any full page.
**Never edit manually.**

Last updated: 2026-04-13
Total pages: 12

---

## Outcomes

- [[outcomes/increase-autonomous-resolution-q2]] — Increase chatbot autonomous resolution rate from 41% to 60% by end of Q2-2026, reducing support costs and improving CX

## Opportunities

- [[opportunities/intent-classification-gap]] — The chatbot misclassifies user intent in 38% of conversations, causing unnecessary escalations — confirmed by data and 7 interviews
- [[opportunities/multilingual-coverage-gap]] — 15% of escalations come from LATAM customers writing in Portuguese or Spanish — the chatbot has near-zero resolution rate for these conversations

## Solutions

- [[solutions/prd-intent-classifier-v2]] — Replace rule-based intent classifier with a fine-tuned LLM classifier trained on Acme's resolved tickets — targeting 38% → ≤10% misclassification rate

## Experiments

- [[experiments/intent-classifier-v2-ab]] — A/B test of the new LLM intent classifier vs rule-based baseline — hypothesis: misclassification drops from 38% to ≤10%

## Decisions

- [[intelligence/decisions/prioritize-intent-over-multilingual]] — Bet Q2 on intent classification fix before multilingual expansion — intent affects 78% of users, multilingual affects 22%, and the ROI gap is clear

## Research

- [[intelligence/research/interview-synthesis-q1]] — 7 customers interviewed about chatbot failures — 6/7 describe intent misclassification as primary frustration; 3 LATAM users report chatbot as completely unusable
- [[intelligence/research/cs-team-voice-of-customer]] — Internal CS team interview — agents estimate 40% of escalated tickets have a wrong first chatbot response; team spends 15min/ticket on context-recovery from bot failures

## Data

- [[intelligence/data/chatbot-funnel-q1]] — Q1 2026 chatbot resolution funnel — 38% of conversations exit at intent classification (highest exit point), only 41% resolve autonomously
- [[intelligence/data/resolution-rate-baseline]] — Autonomous resolution rate metric definition and Q1 2026 baseline — 41%, measured weekly, target 60% by end of Q2

## Market

- [[intelligence/market/intercom-fin-analysis]] — Intercom Fin uses GPT-4 for intent understanding with no rule-based layer — claims 45%+ resolution rates, positions on "understands natural language" vs Acme's structured commands approach

## Sprints & Meetings

- [[ops/meetings/q2-planning-alignment]] — Q2 planning alignment — team agreed to bet Q2 on intent classification fix; multilingual moves to Q3; experiment to start week 3 of April
- [[ops/sprints/sprint-q2-w1]] — Q2 Week 1–2 sprint — goals: PRD approved, training data pipeline set up, experiment infrastructure ready; team of 4 (2 ML, 1 design, 1 BE)
