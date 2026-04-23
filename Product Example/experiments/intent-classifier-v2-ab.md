---
type: experiment
status: active
confidence: medium
explored: false
tldr: A/B test of the new LLM intent classifier vs rule-based baseline — hypothesis: misclassification drops from 38% to ≤10%
---

# Experiment: Intent Classifier v2 — A/B Test

**Hypothesis:** Replacing the rule-based intent classifier with a fine-tuned LLM classifier will reduce misclassification rate from 38% to ≤10%, increasing autonomous resolution rate by ≥10 percentage points.

**Testing:** [[solutions/prd-intent-classifier-v2]]
**Opportunity:** [[opportunities/intent-classification-gap]]
**Outcome:** [[outcomes/increase-autonomous-resolution-q2]]

**Metric:** [[intelligence/data/resolution-rate-baseline]]
**Baseline:** 41% autonomous resolution rate, 38% misclassification rate (Q1 2026)
**Success criterion:** Misclassification rate ≤ 10%, autonomous resolution rate ≥ 51%, p < 0.05

**Design:**
- Control: current rule-based classifier (100% of traffic today)
- Variant: LLM classifier v2
- Traffic split: 50/50 on new conversations
- Minimum sample: 5,000 conversations per variant
- Duration estimate: ~2 weeks at current volume

**Start date:** 2026-04-21 (pending eng completion of variant)
**End date target:** 2026-05-05

**Result:** *(fill when complete)*
**Impact on OST:** *(fill when complete)*

**Risks:**
- Latency: if P99 > 800ms, pause and investigate before continuing
- Cost: LLM API calls add ~$0.003/conversation — acceptable at current volume, monitor if volume spikes
