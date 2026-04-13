---
type: research
status: active
tldr: Internal CS team interview — agents estimate 40% of escalated tickets have a wrong first chatbot response; team spends 15min/ticket on context-recovery from bot failures
---

# Research: CS Team — Voice of Internal Customer

**Participants:** 4 CS agents, 1 CS team lead (Ana Rodrigues, TL for 2.5 years)
**Method:** 45-min group session + 2 individual follow-ups
**Research question:** What does the CS team observe about chatbot failure patterns?
**Date:** 2026-03-15

---

## Key findings

### Finding 1 — Agents classify misclassification as the dominant failure mode
Ana (TL) reviewed 50 random escalated tickets before our session. Her estimate: ~40% had a chatbot transcript where the first response was clearly unrelated to the user's question.

> "You can see it in the transcript. User asks about billing, bot gives them a tutorial on integrations. User asks again. Bot apologizes and gives the same tutorial. By the time they reach us, they're already frustrated." — Ana Rodrigues, CS TL

This internal validation corroborates [[intelligence/research/interview-synthesis-q1]] and [[intelligence/data/chatbot-funnel-q1]].

**Opportunity strengthened:** [[opportunities/intent-classification-gap]]

### Finding 2 — Context-recovery time is a hidden cost
When the chatbot fails, the human agent can't trust the conversation transcript. They restart the interaction from scratch. Agents estimate 15 minutes of additional handle time per escalated ticket specifically due to bot failures (vs tickets that came in via other channels).

At current volume (~800 escalated tickets/month), this adds ~200 hours/month of CS labor that isn't captured in standard AHT metrics.

### Finding 3 — LATAM agents are manually pre-escalating
The two bilingual agents confirmed they've started advising LATAM customers to skip the chatbot entirely and email directly. "We tell them: don't bother with the bot, just email us."

This creates a hidden bypass that inflates the email channel volume and masks the true chatbot failure rate for LATAM.

**Opportunity strengthened:** [[opportunities/multilingual-coverage-gap]]

---

## What this research doesn't tell us

- We can't quantify the hidden cost precisely without instrumenting the CRM to track agent time spent on context-recovery.
- The CS team's 40% estimate is based on a small manual sample — the [[intelligence/data/chatbot-funnel-q1]] data gives us a more reliable baseline.
