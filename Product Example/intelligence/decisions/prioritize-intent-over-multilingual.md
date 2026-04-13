---
type: decision
status: approved
tldr: Bet Q2 on intent classification fix before multilingual expansion — intent affects 78% of users, multilingual affects 22%, and the ROI gap is clear
---

# Decision: Prioritize Intent Classification over Multilingual in Q2

**Context:** Both [[opportunities/intent-classification-gap]] and [[opportunities/multilingual-coverage-gap]] contribute to our Q2 OKR. We had to decide which to build first given that both require significant eng effort.

**Evidence that drove this:**
- [[intelligence/data/chatbot-funnel-q1]] — intent misclassification affects 78% of our user base (English); multilingual gap affects 22%
- [[intelligence/research/interview-synthesis-q1]] — both gaps confirmed qualitatively
- [[ops/meetings/q2-planning-alignment]] — eng capacity: 2 ML engineers available for Q2; both would be needed for either initiative

**Options considered:**

1. ✅ **Intent classification first (Q2), multilingual Q3** — chosen.
   - Impact: fixes primary failure mode for majority of users
   - Time-to-value: can ship and A/B test within Q2
   - Unlocks: multilingual work benefits from better base classifier architecture

2. Multilingual first — rejected.
   - Affects smaller user segment (22%)
   - Higher complexity (translation pipeline + training data per language)
   - Doesn't improve the English majority's experience

3. Both in parallel — rejected.
   - Stretches 2 ML engineers across 2 complex workstreams
   - Risk: neither ships within Q2

**Trade-offs accepted:**
- LATAM customers continue experiencing poor support quality in Q2
- Mitigation: CS team to proactively route LATAM chatbot failures to bilingual agents during Q2

**This decision informs:**
- [[solutions/prd-intent-classifier-v2]]
- [[experiments/intent-classifier-v2-ab]]

> ⚠️ This decision is approved and immutable. To supersede it, create a new decision that links here.
