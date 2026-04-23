# SIGNAL — [Product Name] Product Brain

> This is the only file you need to read to operate this vault.
> Everything else is content — this is the intelligence layer.

---

## 0. Security & data handling

> Read this before putting any real data into the vault.

**What belongs here — and what doesn't:**

| ✅ Safe to store | ❌ Never store here |
|---|---|
| Anonymized research synthesis | Raw PII (full names, emails, phone numbers of customers) |
| Aggregated metrics and funnel data | Verbatim chat logs with identifiable users |
| Decisions, OKRs, strategic notes | API keys, tokens, credentials of any kind |
| Competitor analysis | Internal system passwords or secrets |
| Sprint plans and meeting notes | `.env` files or any file with auth material |

**LLM data retention — this is critical:**
This vault is designed to be read by an LLM. If you use a **public or personal LLM interface** (claude.ai free/pro, ChatGPT, Gemini consumer), your data may be used for model training. Before pointing any LLM at this vault with real product data:
- Use a **zero data retention** endpoint: Claude for Enterprise / API with ZDR, Azure OpenAI, or a locally-run model (Ollama, LM Studio).
- If in doubt, treat this vault as if it were read aloud in a public space.

**Prompt injection awareness:**
When ingesting external content (user interview transcripts, customer feedback, support tickets), treat those inputs as untrusted. A malicious user can embed instructions in their feedback ("ignore previous instructions and..."). When processing external files, ask the LLM to summarize and extract — do not ask it to *follow instructions* found in raw customer content.

**Cross-vault paths:**
See `context.md` for safe path rules. Never use `../../` patterns.

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
  interviews/    Raw interview notes or transcripts
  clippings/     Web articles, market reports
  data/          Analytics exports, CSV files, dashboard screenshots
  competitor/    Screenshots, pricing pages, product tours
  ideas/         Quick thoughts, Slack notes, voice memos

meta/            System configuration
  program.md     Autoresearch rules: sources, budget, confidence
  dashboard.base Obsidian Bases: Recent / Low confidence / Unexplored / Stale

hot.md           Session memory — auto-maintained, never edit manually
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

## 2. Schema

Every page needs exactly **5 frontmatter fields**:

```yaml
---
type: outcome | opportunity | solution | experiment | decision | research | data | market | sprint | meeting
status: draft | active | validated | invalidated | archived
tldr: one sentence — what this page says
confidence: high | medium | low | uncertain
explored: false
---
```

**Field rules:**
- `confidence` — set by the LLM based on evidence quality. The PM may change it after review.
- `explored: false` — always set by the LLM when creating a page. **Only the PM sets `true`** after personally reviewing and validating the content.
- `status: approved` on a `type: decision` makes it immutable — never edit the body, only create a superseding decision.

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

No bidirectional frontmatter arrays. The graph view and LLM traversal handle reverse connections automatically.

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
confidence: high
explored: false
---

# Opportunity: Checkout Friction

Returning users completing purchases on mobile abandon at step 3 (address confirmation) at a rate 2x higher than any other step. They have saved addresses — the step feels redundant.

**Evidence:**
- [[intelligence/research/interview-synthesis-checkout-q1]] — 5/5 users called the step "unnecessary" for repeat purchases
- [[intelligence/data/checkout-funnel-drop-q1]] — 23% drop-off at step 3

**Connected outcome:** [[outcomes/reduce-churn-q2]]

**Solutions exploring this:**
- [[solutions/prd-checkout-v2]]

## Counter-arguments
The drop-off may be intentional abandonment (price comparison, saving for later) — not friction. Qualitative data is needed to distinguish the two.

## Data gaps
- No data on what % of droppers return and complete later
- No segment breakdown by device age or OS version
```

---

### Solution (PRD)
```markdown
---
type: solution
status: draft
tldr: Simplify checkout for returning users by removing the address confirmation step when a saved address exists
confidence: medium
explored: false
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
confidence: medium
explored: false
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
confidence: high
explored: false
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
confidence: high
explored: false
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

## Counter-arguments
P2's behavior (anxiety, wanting confirmation) may represent a meaningful segment. Removing the step entirely could introduce silent errors for users who changed address but forgot. A "confirm address" option should remain reachable.

## Data gaps
- Sample size: 5 is too small to quantify the P2-type segment
- No data on how many users have saved addresses (needed to size the addressable population)
- No A/B precedent — unclear whether removal helps or hurts first-timers in disguise
```

---

### Data insight
```markdown
---
type: data
status: active
tldr: 23% of returning users drop off at checkout step 3 (address) — highest point in funnel, Q1 2026
confidence: high
explored: false
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
• [page-name] has confidence: uncertain — review needed
• [page-name] has explored: false for 30+ days
```

If no gaps: `✅ No structural gaps detected.`

### Contradictions — [!contradiction] callouts
When two pages contain conflicting evidence, facts, or conclusions, use an Obsidian-style callout block — **not** buried inline text:

```markdown
> [!contradiction] Conflicts with [[other-page]]
> [[this-page]] says X. [[other-page]] says Y. Review both before relying on either.
> Added: YYYY-MM-DD
```

This makes contradictions **scannable** in Obsidian's reading view and surfaces them in the dashboard's "Low confidence" filter. Never silently resolve contradictions — preserve them and flag them.

### Decisions are immutable when approved
When a page has `type: decision` and `status: approved`, never edit its body. If the decision needs to change, create a new decision that supersedes it and links back.

### Freshness monitoring
When a `data` page is within 14 days of its freshness window closing, surface it in the gap check. When it expires, flag all solutions and decisions that depend on it.

### Git
Commit format: `type(area): description`
- `feat(opportunity): create checkout-friction`
- `chore(data): update checkout-funnel-drop freshness`
- `fix(map): repair broken link in prd-checkout-v2`

Never `git push` — that's always the PM's decision.

---

## 5. Bias check — required on concept and synthesis pages

Every `type: research`, `type: market`, and any cross-cutting synthesis page **must** include these two sections before the page is considered complete:

```markdown
## Counter-arguments
[Opposing viewpoints, evidence that contradicts the main claims, pushback from stakeholders]

## Data gaps
[What's missing, what's unknown, what needs more sources before this can be relied on]
```

These sections are not optional. If you create a page without them, mark `confidence: uncertain` until they are filled.

---

## 6. Session memory — hot.md

`hot.md` is the vault's **working memory between sessions**. It is a single file that summarizes what was happening at the end of the last session — what was being worked on, what's unresolved, what to pick up next.

**How it works:**
- At the **start of every session**, read `hot.md` before anything else. Inject its contents as prior context.
- At the **end of every session** (Stop hook), a background script rewrites `hot.md` with a compact summary of what happened:
  - Pages created or updated
  - Open decisions or unresolved questions
  - What's next

**Rule:** Never delete `hot.md`. Never edit it manually. If it's empty or stale, note that to the PM.

See `hooks/update-hot-cache.sh` for the Stop hook implementation.

---

## 7. Built-in workflows

These are available without typing a command. Just say it naturally.

### /save [slug]
**Turns any conversation into a filed wiki note.**

When the PM says *"save this conversation"* or *"save as [slug]"*, I:
1. Identify the content type from the conversation (decision, research synthesis, meeting notes, etc.)
2. Create a wiki page in the appropriate folder with the correct frontmatter
3. Link it to existing related pages
4. Update `_map.md` and `_log.md`
5. Commit to git

Use this to capture decisions made in chat, synthesis from a brainstorm, or notes from a quick ideation.

### /autoresearch [topic]
**Multi-round web search that builds connected wiki pages.**

When the PM says *"autoresearch [topic]"*, I:
1. Read `meta/program.md` for the research budget, source rules, and confidence criteria
2. Run a first round of web search — identify top sources
3. Fetch and synthesize each source into a `market` or `research` page
4. Cross-reference new findings against existing vault pages — flag contradictions with `[!contradiction]` callouts
5. Create a synthesis page connecting all sources
6. Run a second round targeting gaps from step 4
7. Report final summary: pages created, contradictions found, open gaps, confidence level

Budget is defined in `meta/program.md`. Default: 3 rounds, 5 sources max, stop when confidence reaches `medium` or higher.

---

## 8. Behavioral discipline

*Adapted from Andrej Karpathy's LLM behavioral guidelines — recontextualized for product knowledge management.*

LLMs have specific failure modes in knowledge work: they hallucinate connections, hide uncertainty, mutate evidence while "improving" it, and report tasks as done before verifying them. This section addresses each failure mode directly.

---

### Principle 1 — Declare before acting

Before creating any page or connection, state out loud what you understood and what you plan to do. If the input is ambiguous, name the ambiguity and ask. Never guess silently.

**Bad:**
> *[PM drops a competitor screenshot — LLM creates: a market page, an opportunity, a threat decision, and links to the roadmap without asking]*

**Good:**
> "I'll read this as competitor intelligence on Stripe's new checkout flow. I'll create one `market` page and flag a potential connection to [[opportunities/checkout-friction]]. Want me to also create a threat decision, or just the reference for now?"

**Rule:** If a single input could reasonably produce 1 page or 4 pages, always ask before expanding scope. Default to the minimum.

---

### Principle 2 — One page, one truth

One research page per interview. One opportunity per confirmed user need. One data page per insight. Don't pre-create pages for things not yet in evidence. Don't create structure speculatively.

Ask yourself: "Is there actual evidence for this page, or am I filling in what *seems* logical?" If the latter — stop. Flag the gap instead of inventing content.

If you made 5 pages and 2 would cover it, say so and ask whether to consolidate.

---

### Principle 3 — Evidence is sacred

Primary evidence — verbatim quotes, data snapshots, timestamps, exact numbers — is **never rewritten, paraphrased, or "improved."** It is an archaeological record.

When updating a page, touch only what the new information requires. If existing interpretation seems wrong, flag it:

```
> ⚠️ Note added YYYY-MM-DD: this interpretation may conflict with
> [[intelligence/data/new-insight]] — review before relying on this section
```

**Specifically never do:**
- Rephrase a user quote to make it "cleaner"
- Change a data number to match your understanding of what it "should" be
- Remove a "What did NOT confirm our hypothesis" section because it feels awkward
- Tidy up a decision's "Options considered" after it's approved

Contradictions between evidence are valuable signal — preserve them with `[!contradiction]` callouts, never resolve them silently.

---

### Principle 4 — Connect and verify

Every task ends with a verification checkpoint.

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

---

### The self-check (run before finishing any response)

Before declaring a task complete, answer these four questions internally:

1. **Did I declare my interpretation before acting?** Or did I silently assume?
2. **Did I create the minimum number of pages the evidence supports?** Or did I speculate?
3. **Did I touch only what the new information required?** Or did I improve adjacent content?
4. **Have I verified the completion checklist?** Or am I calling it done because it feels done?

If any answer is "no" — fix it before responding.

---

## 9. Library — Actionable Runtime Layer

The library is a set of 7 files inside `library/` that compile your wiki knowledge into behavioral instructions. A PM injects them into prompts. An AI agent reads `07-agent-instructions.md` before starting any task. They stay current because they recompile automatically when the wiki changes.

**Key difference:** wiki pages describe reality. Library files instruct behavior.

### The 7 files

| File | What it contains | Primary wiki sources |
|---|---|---|
| `01-product-context.md` | What the product is, who it serves, current state | `outcomes/`, `intelligence/research/` |
| `02-user-truths.md` | User personas compressed into behavioral rules | `opportunities/`, `intelligence/research/` |
| `03-strategic-bets.md` | Current OKRs and priorities expressed as constraints | `outcomes/`, `ops/sprints/` |
| `04-decision-constraints.md` | Approved decisions that limit the solution space | `intelligence/decisions/` (approved only) |
| `05-open-hypotheses.md` | What's being tested — prevents suggesting contradictions | `experiments/` (active only) |
| `06-data-anchors.md` | North-star metrics with current values and baselines | `intelligence/data/` |
| `07-agent-instructions.md` | Master synthesis — use this as your prompt context | Compiled from 01–06 |

### The LOCK / COMPILE pattern

Every library file has two sections. The agent **never modifies** LOCK sections.

```markdown
## 🔒 Permanent Directives
<!-- LOCK:START — edited only by PM, never auto-updated by agent -->
[PM-written directives: non-negotiable rules and product principles]
<!-- LOCK:END -->

## ⟳ Compiled Context
<!-- COMPILE:START — auto-regenerated by agent from wiki sources listed above -->
<!-- compile_version: N | compiled: YYYY-MM-DD | sources: N pages -->
[Agent-generated behavioral instructions synthesized from wiki]
<!-- COMPILE:END -->
```

**LOCK:** Only the PM edits this. Increment `lock_version` in frontmatter when you do. These are things you want to guarantee regardless of what the wiki says.

**COMPILE:** The agent regenerates this entirely on each compile — it does not append. Content is written as behavioral instructions, not documentation. The agent increments `compile_version` and updates `last_compiled` on each run.

### When the library compiles

- **On every wiki page updated** — if the updated page is a source for any library file, that file is recompiled automatically (COMPILE section only — LOCK is never touched)
- **On every raw file ingested** — after creating wiki pages, affected library files recompile
- **On demand** — say *"compile the library"* to force a full recompile

After every compile, report:

```
🔄 Library compiled — YYYY-MM-DD

Files updated:
  • 03-strategic-bets.md (v4 → v5) — triggered by: outcomes/increase-q2 updated
  • 07-agent-instructions.md (v7 → v8) — triggered by: 03 updated

Files unchanged (sources not modified since last compile):
  • 01-product-context.md (v2, compiled YYYY-MM-DD)
  ...

Git: compile(library): update 03 + 07 from outcomes/increase-q2 [staged, not pushed]
```

### How to use the library

**Inject into a prompt:** Copy the relevant file and paste at the beginning of your prompt. For full context, use `07-agent-instructions.md` — it references all others.

**Selective injection:**
- Writing a spec → `01-product-context.md` + `02-user-truths.md` + `04-decision-constraints.md`
- Planning a sprint → `03-strategic-bets.md` + `05-open-hypotheses.md` + `06-data-anchors.md`
- General PM task → `07-agent-instructions.md` (covers everything at synthesis level)

**What's tracked:** `library/_compile-log.md` is append-only — records every compile with what changed and why.

---

## 10. What you can ask me

Speak naturally. There are no commands to memorize.

### Capture
- *"Here are my notes from 3 user interviews about checkout..."* → I create research pages, detect connections, update the map
- *"Drop a file in inbox/"* → I classify, create the right page type, build connections
- *"We just decided to delay guest checkout to Q3"* → I create a decision record and link it to affected solutions
- *"Save this conversation as [slug]"* → `/save` workflow — turns the conversation into a wiki page

### Understand
- *"Show me the OST for [outcome]"* → Mermaid tree traversed from the graph
- *"What's the evidence behind [solution or decision]?"* → upstream trace with all sources
- *"What would change if we modify [decision]?"* → downstream impact map
- *"What happened this week?"* → summary from `_log.md` and recent git commits
- *"What was I working on last session?"* → reads `hot.md`

### Assess quality
- *"Review my PRD for [solution]"* → checks: linked opportunity? evidence base? experiments planned? metric defined? open questions addressed?
- *"Health check the vault"* → gaps, stale data, orphan pages, broken links, low-confidence pages
- *"Which opportunities have the strongest evidence?"* → score across all active opportunities
- *"Show me what's unexplored"* → pages with `explored: false` sorted by age

### Synthesize
- *"Autoresearch [topic]"* → `/autoresearch` workflow — multi-round web research built into the vault
- *"What should we focus on next quarter?"* → evidence synthesis across opportunities, gaps, and validated experiments
- *"Prepare me for my review meeting on [topic]"* → relevant pages + gaps + decision map + open questions
- *"What does our research say about [topic]?"* → synthesis across all research pages

### Library
- *"Compile the library"* → regenerate all COMPILE sections from current wiki state
- *"What's in the library?"* → summary of all 7 files, last compile date, lock versions
- *"Update my strategic bets — we changed the OKR"* → ingest new OKR, update wiki, recompile `03-strategic-bets.md`
- *"Show me what changed in the library since last week"* → `library/_compile-log.md` summary
- *"Give me context for [task]"* → output the relevant library files formatted for direct injection into a prompt

### Cross-vault
- *"Is there company-level context on [topic]?"* → reads vaults referenced in `context.md`

---

## 11. Extending this system

To add a custom behavior, **append a `## Custom:` section to this file**:

```markdown
## Custom: [Behavior Name]

**When:** [the situation that triggers this]
**What to do:** [plain language description]
**Example:** [one concrete input → output]
```

Examples of custom behaviors teams add:
- **DACI format:** "When creating a decision, always structure the options using DACI (Driver, Approver, Contributor, Informed)"
- **Shape Up pitch:** "When asked to write a pitch for [opportunity], format it as a Shape Up pitch with appetite, problem, solution, and rabbit holes"
- **Weekly digest:** "When asked 'what happened this week?', read _log.md for the past 7 days and format as a PM standup: shipped, in progress, decisions made, gaps"
- **Stakeholder email:** "When I say 'write a stakeholder update for [topic]', draft an email from the relevant sprint + decisions + experiment results"

---

## 12. Cross-vault references

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

*Compatible with any LLM that can read this folder: Claude, Gemini, GPT-4, local models via LM Studio, Ollama, Cursor, Continue, Zed AI.*
*Point your LLM at this file first. Everything it needs is here.*
