---
type: opportunity
status: active
confidence: medium
explored: false
tldr: The chatbot misclassifies user intent in 38% of conversations, causing unnecessary escalations — confirmed by data and 7 interviews
---

# Opportunity: Intent Classification Gap

Acme's chatbot fails to correctly identify what the user wants in nearly 4 out of 10 conversations. When intent is misclassified, the bot gives an irrelevant response, the user repeats themselves, frustration builds, and the conversation escalates to a human agent. This is the single largest driver of failed autonomous resolutions.

**Evidence:**

**Quantitative:**
- [[intelligence/data/resolution-rate-baseline]] — 38% misclassification rate across 12,400 conversations in Q1 2026
- [[intelligence/data/chatbot-funnel-q1]] — misclassification is the #1 exit point in the resolution funnel (2x higher than the next cause)

**Qualitative:**
- [[intelligence/research/interview-synthesis-q1]] — 6/7 users described repeating themselves multiple times before escalating; 4 said they "gave up on the bot"
- [[intelligence/research/cs-team-voice-of-customer]] — CS team reports that ~40% of escalated tickets contain a chatbot transcript where the first response was clearly wrong

**Connected outcome:** [[outcomes/increase-autonomous-resolution-q2]]

**Solutions exploring this:**
- [[solutions/prd-intent-classifier-v2]]

**What this opportunity does NOT include:**
- Multilingual intent failures (a distinct gap — see [[opportunities/multilingual-coverage-gap]])
- Resolution failures caused by missing knowledge base articles (separate backlog item)
