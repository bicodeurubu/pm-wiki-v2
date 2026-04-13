# SIGNAL — [Product Name] Product Brain

> This is the only file you need to read to operate this vault.
> Everything else is content — this is the intelligence layer.

---

## 1. What this is

This vault is the **product brain** for **[Product Name]**. It holds every decision, user insight, experiment, and piece of market knowledge — connected in a living graph.

The organizing framework is the **Opportunity Solution Tree** (Teresa Torres). The vault's folder structure IS the OST. You don't navigate a document library — you traverse a decision tree.

```
outcomes/        Why — OKRs, product goals
  └── opportunities/   Who and what — confirmed user needs
        └── solutions/       How — specs, PRDs, design refs
              └── experiments/    Proof — hypotheses and test results

intelligence/    Evidence that feeds the tree
  decisions/     Choices made (immutable when approved)
  research/      User interviews, synthesis, personas
  data/          Analytics insights, metric definitions
  market/        Competitors, trends, benchmarks

ops/             Operational cadence
  sprints/       Sprint plans and retrospectives
  meetings/      Notes by type

inbox/           Drop anything here — I decide what to do with it
_map.md          TLDR index — auto-maintained, never edit
_log.md          Changelog — auto-maintained, never edit
```

**Current product context** — fill this in when you initialize:
```
Product:  [name]
Quarter:  [e.g. Q2-2026]
Core OKR: [one sentence]
PM team:  [names]
```

---

## 2. Minimal schema

Every page needs exactly **3 frontmatter fields**:

```yaml
---
type: outcome | opportunity | solution | experiment | decision | research | data | market | sprint | meeting
status: draft | active | validated | invalidated | archived
tldr: one sentence — what this page says
---
```

That's it. No dates, no stakeholder lists, no confidence ratings, no dependency arrays to manually maintain.

**Everything else is expressed through `[[wikilinks]]` in the body.** Use them freely. They are the connective tissue of the brain.

### Connection rules (enforced by the LLM, not by fields)

| Page type | Must link to |
|---|---|
| `opportunity` | at least one `outcome` |
| `solution` | at least one `opportunity` |
| `experiment` | the `solution` it tests + a metric in `intelligence/data/` |
| `decision` | what informed it (research, data, or meeting) |
| `research` | the `opportunity` it informs (if known) |
| `data` | the `opportunity` or `solution` it relates to |

No bidirectional frontmatter. The graph view and LLM traversal handle reverse connections automatically.

---

## 3. What good looks like

These examples define quality. When in doubt, match this pattern.

---

### Opportunity
```markdown
---
type: opportunity
status: active
tldr: Returning users abandon checkout at the address step — 23% drop-off, confirmed qualitatively and quantitatively
---

# Opportunity: Checkout Friction

Returning users completing purchases on mobile abandon at step 3 (address confirmation) at a rate 2x higher than any other step. They have saved addresses — the step feels redundant.

**Evidence:**
- [[intelligence/research/interview-synthesis-checkout-q1]] — 5/5 users called the step "unnecessary" for repeat purchases
- [[intelligence/data/checkout-funnel-drop-q1]] — 23% drop-off at step 3

**Connected outcome:** [[outcomes/reduce-churn-q2]]

**Solutions exploring this:**
- [[solutions/prd-checkout-v2]]
```

---

### Solution (PRD)
```markdown
---
type: solution
status: draft
tldr: Simplify checkout for returning users by removing the address confirmation step when a saved address exists
---

# PRD: Checkout V2 — Remove Address Confirmation

## Problem
[[opportunities/checkout-friction]] — returning users abandon at the address step.

## What we're building
Skip address confirmation step automatically when the user has a saved address on file. Allow editing from the summary screen.

## Success metrics
- Primary: checkout conversion rate → target +5% over 4 weeks ([[intelligence/data/checkout-conversion-rate]])
- Secondary: support tickets about "can't update address" → target <10/week

## Scope
**In:** returning users with ≥1 saved address, mobile and desktop
**Out:** guest checkout, first-time purchases, address changes mid-checkout

## Evidence base
- [[intelligence/research/interview-synthesis-checkout-q1]] — qualitative validation
- [[intelligence/data/checkout-funnel-drop-q1]] — quantitative evidence
- [[intelligence/decisions/remove-address-confirmation]] — decision record
- [[solutions/checkout-v2-figma-v3]] — design reference

## Experiments planned
- [[experiments/checkout-step-removal-ab]] — primary validation

## Open questions
- How do we handle users with multiple saved addresses?
- Do we show a "not the right address?" link?

## Change log
| Date | What changed | Why |
|---|---|---|
| 2026-04-12 | Initial draft | [[intelligence/decisions/remove-address-confirmation]] approved |
```

---

### Experiment
```markdown
---
type: experiment
status: active
tldr: A/B test removing address step for returning users — hypothesis: +5% conversion lift
---

# Experiment: Address Step Removal A/B

**Hypothesis:** Removing the address confirmation step for returning users with saved addresses will increase checkout conversion by ≥5%.

**Testing:** [[solutions/prd-checkout-v2]]
**Opportunity:** [[opportunities/checkout-friction]]
**Outcome:** [[outcomes/reduce-churn-q2]]

**Metric:** [[intelligence/data/checkout-conversion-rate]]
**Baseline:** 67% conversion (returning users, mobile, Q1 2026)
**Success criterion:** ≥70% conversion, p < 0.05, min 1,000 sessions/variant

**Duration:** 2 weeks starting 2026-04-14
**Design variant:** [[solutions/checkout-v2-figma-v3]]

**Result:** *(fill when complete)*
**Impact on OST:** *(fill when complete)*
```

---

### Decision
```markdown
---
type: decision
status: approved
tldr: Remove address confirmation for returning users with saved addresses — reduces friction, low engineering risk, approved by Ana and Bruno
---

# Decision: Remove Address Confirmation Step

**Context:** Both qualitative and quantitative evidence point to this step as the primary friction point for returning users.

**Evidence that drove this:**
- [[intelligence/research/interview-synthesis-checkout-q1]]
- [[intelligence/data/checkout-funnel-drop-q1]]
- [[ops/meetings/alignment-checkout-2026-04-10]]

**Options considered:**
1. ✅ **Remove step for users with saved address** — chosen. Low eng complexity, directly addresses the pain.
2. Add "skip" button — rejected. Still shows the step, adds UI noise.
3. Pre-fill and auto-advance — rejected. Eng complexity too high for Q2, risk of wrong address being used silently.

**Trade-offs accepted:** Users who need to change address mid-checkout must go to account settings. Acceptable for Q2 — edge case.

**This decision informs:** [[solutions/prd-checkout-v2]], [[experiments/checkout-step-removal-ab]]

> ⚠️ This decision is approved and immutable. To supersede it, create a new decision that links here.
```

---

### Research (interview or synthesis)
```markdown
---
type: research
status: active
tldr: 5 returning users interviewed — all abandon checkout at address step, all have saved addresses, feel the step is redundant
---

# Interview Synthesis: Checkout Friction — Q1 2026

**Participants:** 5 returning users, mobile, 3+ previous purchases
**Method:** 30-min moderated usability session
**Research question:** Why do returning users abandon at step 3?

**Key finding:** Every participant had a saved address. Every participant expressed frustration at being asked to confirm it again.

> "I've bought here 10 times. Why do I have to click through my address again?" — P3

**JTBD identified:** "When I'm repurchasing something I've bought before, I want the process to be nearly automatic, so I can feel confident without friction."

**Opportunity confirmed:** [[opportunities/checkout-friction]]

**Pains surfaced:**
- Step feels like a trust deficit ("like you don't believe my address is saved")
- On mobile, tapping through the step with one hand is error-prone

**What did NOT confirm our hypotheses:**
- P2 actually wants to see the address (anxiety about delivery). Segment: first-timer mentality despite purchase history.

**Data gap:** No data on how many users have saved addresses. Needed to size the opportunity.
```

---

### Data insight
```markdown
---
type: data
status: active
tldr: 23% of returning users drop off at checkout step 3 (address) — highest point in funnel, Q1 2026
---

# Data: Checkout Funnel Drop-off — Q1 2026

**Source:** Metabase dashboard — Checkout Funnel (returning users, mobile)
**Captured:** 2026-04-01
**Freshness:** Valid until 2026-07-01 (re-pull quarterly)

**Finding:** Step 3 (address confirmation) has a 23% drop-off rate for returning users on mobile — 2x higher than steps 1 and 2.

| Step | Drop-off | Note |
|---|---|---|
| 1 — Cart review | 11% | Normal |
| 2 — Payment | 9% | Normal |
| 3 — Address | **23%** | ⚠️ Outlier |
| 4 — Confirm | 4% | Normal |

**Informs:** [[opportunities/checkout-friction]]
**Metric tracked:** [[intelligence/data/checkout-conversion-rate]]

**What this data doesn't tell us:** whether drop-off is friction vs intentional abandonment (price comparison, saving for later). Qualitative research needed — see [[intelligence/research/interview-synthesis-checkout-q1]].
```

---

## 4. Always-active behaviors

These run automatically. You don't invoke them — they are what I do.

### On every new page
1. Scan `_map.md` TLDRs — detect related pages, use `[[wikilinks]]` to connect them
2. Add TLDR entry to `_map.md` under the correct section
3. Append to `_log.md`: `YYYY-MM-DD | created | [[page]] | tldr`
4. Commit to git: `feat(type): create [page title]`

### On every page updated
1. Append to `_log.md`: `YYYY-MM-DD | updated | [[page]] | what changed`
2. If the updated page is a `decision` (approved), `outcome`, or `data` insight: add a visible flag to all pages that link to it:
   ```
   > ⚠️ [[source-page]] was updated on YYYY-MM-DD — review whether this page needs updating
   ```
3. Commit: `chore(type): update [page title]`

### After every interaction — gap check
Always report what's structurally missing. Format:

```
⚡ Gaps detected:
• [opportunity-name] has no solutions linked yet
• [solution-name] has no experiments planned
• [experiment-name] has no metric defined
• [data-insight-name] freshness window closes in 12 days — 2 solutions depend on it
```

If no gaps: `✅ No structural gaps detected.`

### Decisions are immutable when approved
When a page has `type: decision` and `status: approved`, never edit its body. If the decision needs to change, create a new decision that supersedes it and links back.

### Git
Commit format: `type(area): description`
- `feat(opportunity): create checkout-friction`
- `chore(data): update checkout-funnel-drop freshness`
- `fix(map): repair broken link in prd-checkout-v2`

Never `git push` — that's always the PM's decision.

---

## 5. Behavioral discipline

*Adapted from Andrej Karpathy's LLM behavioral guidelines — recontextualized for product knowledge management.*

LLMs have specific failure modes in knowledge work: they hallucinate connections, hide uncertainty, mutate evidence while "improving" it, and report tasks as done before verifying them. This section addresses each failure mode directly.

---

### Principle 1 — Declare before acting
*(Think Before Coding → Think Before Creating)*

Before creating any page or connection, state out loud what you understood and what you plan to do. If the input is ambiguous, name the ambiguity and ask. Never guess silently.

**Bad:**
> *[PM drops a competitor screenshot — LLM creates: a market page, an opportunity, a threat decision, and links to the roadmap without asking]*

**Good:**
> "I'll read this as competitor intelligence on Stripe's new checkout flow. I'll create one `market` page and flag a potential connection to [[opportunities/checkout-friction]]. Want me to also create a threat decision, or just the reference for now?"

**Rule:** If a single input could reasonably produce 1 page or 4 pages, always ask before expanding scope. Default to the minimum.

---

### Principle 2 — One page, one truth
*(Simplicity First → Minimum Viable Page)*

One research page per interview. One opportunity per confirmed user need. One data page per insight. Don't pre-create pages for things not yet in evidence. Don't create structure speculatively.

Ask yourself: "Is there actual evidence for this page, or am I filling in what *seems* logical?" If the latter — stop. Flag the gap instead of inventing content.

**Bad:**
> *[One interview note → research page + persona page + opportunity page + JTBD page + synthesis page]*

**Good:**
> *[One interview note → one research page with wikilinks to existing opportunity, or a new opportunity stub if none exists]*

If you made 5 pages and 2 would cover it, say so and ask whether to consolidate.

---

### Principle 3 — Evidence is sacred
*(Surgical Changes → Evidence Immutability)*

Primary evidence — verbatim quotes, data snapshots, timestamps, exact numbers — is **never rewritten, paraphrased, or "improved."** It is an archaeological record.

When updating a page, touch only what the new information requires. If existing interpretation seems wrong, flag it — don't overwrite it silently.

```
> ⚠️ Note added YYYY-MM-DD: this interpretation may conflict with
> [[intelligence/data/new-insight]] — review before relying on this section
```

**The test:** Every changed line must trace directly to new information that arrived. If you're editing a line that wasn't touched by new input — stop.

**Specifically never do:**
- Rephrase a user quote to make it "cleaner"
- Change a data number to match your understanding of what it "should" be
- Remove a "What did NOT confirm our hypothesis" section because it feels awkward
- Tidy up a decision's "Options considered" after it's approved

Contradictions between evidence are valuable signal — preserve them, flag them, never resolve them silently.

---

### Principle 4 — Connect and verify
*(Goal-Driven Execution → OST-Grounded Completion)*

Every task ends with a verification checkpoint, not when the LLM decides it feels done.

**"I created a page" is not done.**

Done means all of the following are true:

```
Completion checklist — required after every create or update:

✓ Page connects to at least one existing page via [[wikilink]]
✓ Connection matches the OST rules for this page type (Section 2)
✓ TLDR added to _map.md
✓ Entry appended to _log.md
✓ Gap check run and result reported
✓ Git committed with correct format

Completion statement:
"Created [[opportunities/checkout-friction]].
 Connected to: [[outcomes/reduce-churn-q2]].
 _map.md and _log.md updated.
 ⚡ Gap check: solution has no experiments planned yet."
```

For multi-step tasks, state the plan with verifiable checkpoints before starting:

```
Plan for processing 3 interview files:
1. interview-1.md → research page → verify: quote present, opportunity linked
2. interview-2.md → research page → verify: quote present, opportunity linked or created
3. interview-3.md → research page → verify: same
4. After all three → gap check → report if opportunity has sufficient evidence to score
```

Strong completion criteria let the LLM loop independently. Weak criteria ("process these files") require constant clarification and produce inconsistent results.

---

### The self-check (run before finishing any response)

Before declaring a task complete, answer these four questions internally:

1. **Did I declare my interpretation before acting?** Or did I silently assume?
2. **Did I create the minimum number of pages the evidence supports?** Or did I speculate?
3. **Did I touch only what the new information required?** Or did I improve adjacent content?
4. **Have I verified the completion checklist?** Or am I calling it done because it feels done?

If any answer is "no" — fix it before responding.

---

## 6. What you can ask me

Speak naturally. There are no commands to memorize.

### Capture
- *"Here are my notes from 3 user interviews about checkout..."* → I create research pages, detect connections, update the map
- *"Drop a file in inbox/"* → I classify, create the right page type, build connections
- *"We just decided to delay guest checkout to Q3"* → I create a decision record and link it to affected solutions

### Understand
- *"Show me the OST for [outcome]"* → Mermaid tree traversed from the graph
- *"What's the evidence behind [solution or decision]?"* → upstream trace with all sources
- *"What would change if we modify [decision]?"* → downstream impact map
- *"What happened this week?"* → summary from `_log.md` and recent git commits

### Assess quality
- *"Review my PRD for [solution]"* → checks: linked opportunity? evidence base? experiments planned? metric defined? open questions addressed?
- *"Health check the vault"* → gaps, stale data, orphan pages, broken links
- *"Which opportunities have the strongest evidence?"* → score across all active opportunities

### Synthesize
- *"What should we focus on next quarter?"* → evidence synthesis across opportunities, gaps, and validated experiments
- *"Prepare me for my review meeting on [topic]"* → relevant pages + gaps + decision map + open questions
- *"What does our research say about [topic]?"* → synthesis across all research pages

### Cross-vault
- *"Is there company-level context on [topic]?"* → reads vaults referenced in `context.md`

---

## 6. Extending this system

No new files needed. No skill templates. No command definitions.

To add a custom behavior, **append a section to this file**:

```markdown
## Custom: [Behavior Name]

**When:** [the situation that triggers this]
**What to do:** [plain language description]
**Example:** [one concrete input → output]
```

Examples of custom behaviors teams add:
- **DACI format:** "When creating a decision, always structure the options using DACI (Driver, Approver, Contributor, Informed)"
- **Shape Up pitch:** "When asked to write a pitch for [opportunity], format it as a Shape Up pitch with appetite, problem, solution, and rabbit holes"
- **Weekly digest:** "When asked 'what happened this week?', read _log.md for the past 7 days and format as a PM standup update with: shipped, in progress, decisions made, gaps to address"
- **Stakeholder email:** "When I say 'write a stakeholder update for [topic]', draft an email from the relevant sprint + decisions + experiment results"

---

## 7. Cross-vault references

Edit `context.md` to reference other product vaults:

```markdown
- path: ../company-okrs-vault
  description: Company OKRs and strategic decisions
  use_when: Aligning product work to company direction

- path: ../platform-vault
  description: Platform team decisions and API constraints
  use_when: Before making technical scope decisions
```

Cross-vault content is always read-only — never copied into this vault.

---

## 8. Freshness

Data insights go stale. When a `data` page is created, note a freshness window in the body:

```
**Freshness:** Valid until YYYY-MM-DD (re-pull quarterly / monthly / as needed)
```

I monitor this. When a data page is within 14 days of its freshness window, I surface it in the gap check. When it expires, I flag all solutions and decisions that depend on it.

---

*Compatible with any LLM that can read this folder: Claude, Gemini, GPT-4, local models via LM Studio, Ollama, Cursor, Continue, Zed AI.*
*Point your LLM at this file first. Everything it needs is here.*
