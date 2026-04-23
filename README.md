# PM-Wiki v2.1 — The Product Brain

**A vault where you drop your raw product knowledge, and an LLM turns it into a connected, traceable decision graph.**

One instruction file (`SIGNAL.md`). No plugin setup. No commands to memorize. You talk — the brain builds itself.

---

## The Story: Managing a Product with This Vault

Imagine you're a PM on a B2B support platform. Your Q2 OKR is to increase autonomous ticket resolution. You've just finished three user interviews, your data analyst sent you a funnel export, and your team made a call in Slack about dropping a feature from scope.

Here's what that day looks like inside the vault.

---

### Step 1 — Drop your raw material into `inbox/`

The inbox is your zero-friction entry point. No formatting required. No decisions about where things go yet.

```
inbox/
  interviews/     ← drop your interview notes or transcripts here
  data/           ← CSV exports, dashboard screenshots, funnel numbers
  clippings/      ← market articles, competitor teardowns, research papers
  competitor/     ← screenshots, pricing pages, product tour notes
  ideas/          ← quick thoughts, Slack threads, voice memo transcripts
```

You paste your three interview notes into `inbox/interviews/`, drop the funnel CSV in `inbox/data/`, and paste the Slack thread into `inbox/ideas/`. You tell the LLM: *"Process what's in the inbox."*

That's the entire PM action. What happens next is the motor.

---

### Step 2 — The Motor: What happens after you say "process"

The LLM reads each file, classifies it, and decides what type of wiki page it becomes. Classification is based on content signals — not filenames.

| What the LLM finds in the file | What it creates | Where it lands |
|---|---|---|
| Interview questions + user quotes | `type: research` page | `intelligence/research/` |
| Funnel numbers, drop-off rates, conversion data | `type: data` page | `intelligence/data/` |
| Competitor name + features/pricing | `type: market` page | `intelligence/market/` |
| Structured problem/solution/metrics | `type: solution` draft | `solutions/` |
| Decision made, options considered | `type: decision` | `intelligence/decisions/` |
| Meeting agenda + action items | `type: meeting` | `ops/meetings/` |
| Rough thought, no clear category | `concept` stub | relevant folder, flagged for PM |

For your three interviews, the LLM creates three research pages. It reads them, detects a common pattern (users mention friction at a specific step), and either connects them to an existing opportunity or creates a new one in `opportunities/`.

**The LLM declares its interpretation before acting.** It will say something like:

> "I'll create 3 research pages from these interviews. I detect a common thread around checkout friction — this connects to [[opportunities/intent-classification-gap]] or I can create a new opportunity. Which do you prefer?"

This is intentional. The system is built to ask before expanding scope, not to silently generate a dozen pages.

---

### Step 3 — The Cascade: What gets updated, and in what order

Once a page is created or updated, a fixed sequence runs automatically. Every time.

```
1. New page created in the right folder
       ↓
2. TLDR entry added to _map.md  (the vault's index — what exists and what it says)
       ↓
3. Entry appended to _log.md  (the immutable changelog — what changed and when)
       ↓
4. [[wikilinks]] added to connect the new page to existing pages
       ↓
5. Opportunity Solution Tree (OST) traversal:
   — does this research connect to a known opportunity?
   — does that opportunity have a solution?
   — does the solution have an experiment?
   — what's structurally missing?
       ↓
6. Gap check report surfaced to PM
       ↓
7. Git commit  (format: feat(research): create checkout-friction-interviews-q2)
```

For your data file specifically, the LLM also sets a `freshness` window — a date after which the numbers are considered stale. When that window approaches, the vault will flag it automatically.

---

### Step 4 — The Opportunity Solution Tree emerges from the graph

The OST is not a document you maintain. It's a view that the LLM generates by traversing `[[wikilinks]]`.

```
outcomes/increase-autonomous-resolution-q2
  └── opportunities/intent-classification-gap
        └── solutions/prd-intent-classifier-v2
              └── experiments/intent-classifier-v2-ab
```

Every time you ask *"show me the OST"*, the LLM re-traverses the current graph and renders a Mermaid diagram. It doesn't cache it — the tree reflects the actual state of the vault at that moment.

Connection rules are enforced by the LLM, not by the filesystem:
- An `opportunity` must link to at least one `outcome`
- A `solution` must link to at least one `opportunity`
- An `experiment` must link to the `solution` it tests and a metric in `intelligence/data/`
- A `decision` must link to what informed it

If you create a solution without an opportunity link, the gap check surfaces it: `⚡ solutions/prd-intent-v2 has no linked opportunity`.

---

### Step 5 — Persistent state: the three files that hold vault memory

Three files are auto-maintained and never manually edited:

**`hot.md` — Session memory**
At the end of every session, a Stop hook runs in the background and rewrites `hot.md` with a compact summary of what happened: what was created, what's unresolved, what to pick up next. At the start of your next session, the LLM reads this first — so you don't have to re-explain context.

```
## Session: 2026-04-23
### What happened
- Created 3 research pages from checkout interviews
- New opportunity: intent-classification-gap linked to Q2 OKR
### Open threads
- Data page from funnel CSV is low confidence — only one source
### Pick up next
- Define success metric for intent-classifier-v2
```

**`_log.md` — The audit trail**
Every create, update, and propagation is appended here. It's append-only — never rewritten. This is how you answer "what changed this week?" or "when did we change the scope of this feature?". Format:

```
2026-04-23 | created | [[intelligence/research/checkout-interviews-q2]] | 3 user interviews, checkout friction theme
2026-04-23 | updated | [[opportunities/intent-classification-gap]] | linked to new research
```

**`_map.md` — The TLDR index**
Every page has a one-sentence TLDR in `_map.md`. This is how the LLM scans the vault efficiently — it reads `_map.md` first before opening any individual file. Think of it as the table of contents your LLM actually uses.

---

### Step 6 — The Library: compiled actionable runtime

After every ingest, the vault does one more thing: it recompiles the library files that were affected by the new wiki content.

The `library/` folder holds 7 files distilled from your wiki into behavioral instructions — not documentation. A PM injects them into prompts. An AI agent reads `07-agent-instructions.md` before any task. They stay current because they recompile when the wiki changes.

```
library/
  01-product-context.md      What the product is — compiled as product constraints
  02-user-truths.md          Who your users are — compiled as behavioral rules
  03-strategic-bets.md       Current OKRs — compiled as prioritization constraints
  04-decision-constraints.md Approved decisions — compiled as solution space limits
  05-open-hypotheses.md      Active experiments — compiled as "don't contaminate this"
  06-data-anchors.md         North-star metrics — compiled as data anchors
  07-agent-instructions.md   Master synthesis — inject this for full context
  _compile-log.md            Append-only compile audit trail
```

Each file has two sections:
- **🔒 Permanent Directives** — written by you, never auto-updated
- **⟳ Compiled Context** — auto-generated from the wiki on every relevant change

Both sections are versioned (`compile_version: N`, `lock_version: N`) — so you always know whether your library is in sync with your wiki.

**How to use it:**
- *"Compile the library"* → regenerates all COMPILE sections from current wiki state
- *"Give me context for writing the spec"* → injects the right library files into your next prompt
- *"Show me what changed in the library since last week"* → reads `_compile-log.md`

The library is what makes context injection practical: instead of pointing an LLM at 30 wiki pages and hoping it reads them all, you inject one file and get the synthesized behavioral instructions.

---

### Step 7 — Saving conversations as wiki pages

Not everything starts in the inbox. Sometimes the most important knowledge lives in a conversation — a decision you talked through, a hypothesis you shaped, a stakeholder alignment you reached.

At any point you can say: *"Save this conversation as checkout-scope-decision"*

The LLM will:
1. Classify the conversation content (most likely a `decision` or `meeting`)
2. Create the wiki page in the right folder with correct frontmatter
3. Link it to the relevant existing pages
4. Update `_map.md`, `_log.md`, and commit to git

The `/save` command is how product knowledge that lives "in chat" becomes permanent and traceable.

---

### Step 7 — What the system won't do (by design)

A few behaviors are intentionally off-limits:

- **It won't rewrite approved decisions.** A `type: decision` with `status: approved` is immutable. If the decision changes, a new decision is created that links to and supersedes the old one.
- **It won't silently resolve contradictions.** When two pages conflict, a visible `[!contradiction]` callout appears on both. The PM resolves contradictions — the LLM only flags them.
- **It won't `git push`.** Commits are automatic. Pushes are always the PM's call.
- **It won't mark a page as `explored: true`.** That field belongs to the PM — it means "I've personally read and validated this." The LLM sets it to `false` on creation, always.

---

## Getting Started

### 1. Clone and open

```bash
git clone https://github.com/bicodeurubu/pm-wiki-v2.git my-product-vault
cd my-product-vault
```

Open the folder in Obsidian. Enable **Graph View** and the **Bases** community plugin for the live dashboard.

Want to see it populated first? Open `Product Example/` — a fictional support AI product with outcomes, opportunities, PRDs, experiments, and decisions all connected.

### 2. Set your context

Open `SIGNAL.md` and fill in Section 1 (takes 2 minutes):

```
Product:  [your product name]
Quarter:  Q2-2026
Core OKR: [one sentence]
PM team:  [names]
```

### 3. (Optional) Set up session memory

Add the Stop hook so `hot.md` updates automatically after each session:

```json
// .claude/settings.json
{
  "hooks": {
    "Stop": [{ "type": "command", "command": "bash hooks/update-hot-cache.sh" }]
  }
}
```

Requires `claude` CLI and `jq` (`brew install jq`).

### 4. Start talking

```
"Process the files in my inbox"
→ Each file classified, pages created, OST connected, gaps reported

"Here are notes from a call where we decided to cut the export feature"
→ Decision record created, linked to affected solutions, changelog updated

"Autoresearch conversational AI trends in B2B support"
→ 3-round web research, market pages created, contradictions flagged

"Show me the OST for our main OKR"
→ Mermaid tree generated from the live graph

"Health check the vault"
→ Stale data, orphan pages, low-confidence pages, unexplored pages reported

"What was I working on last session?"
→ Reads hot.md and restores context
```

---

## FAQ: 5 Things PMs Miss

**1. The OST is never "built" — it's always being traversed.**
There's no command to "update the OST." The tree exists as long as the wikilinks exist. When you create an opportunity that links to an outcome and a solution that links to that opportunity, the OST already reflects it. Ask for it at any time — it's always current.

**2. `explored: false` is not a bug — it's a signal for you.**
Every page the LLM creates has `explored: false`. This means: "I created this from your input, but you haven't personally reviewed it yet." The dashboard's "Unexplored" view shows these pages sorted by age. Marking a page `explored: true` is a deliberate PM act — your sign-off that you've read and validated it. The LLM never does this for you.

**3. Decisions are append-only, not editable.**
When you change your mind on a decision that was already `status: approved`, you don't edit the page. You create a new decision that says "this supersedes [[decisions/old-decision]]." This is how you maintain an honest audit trail. Future PMs (or future you) will see not just the current decision, but the full chain of reasoning that led there.

**4. The gap check after every interaction is not noise.**
Lines like `⚡ solution has no experiments planned` or `⚡ data page expires in 12 days` are the vault telling you where its graph has holes. These are actionable signals, not status messages. A vault with zero gaps in the gap check is a vault whose OST is structurally complete.

**5. `hot.md` only works if the Stop hook is configured.**
If you don't set up the Stop hook, `hot.md` never gets written, and session memory doesn't exist. The vault still works — you just start every session cold. Set up the hook once (3 minutes) and session continuity becomes automatic.

---

## Quick Reference

### Key files

| File | What it is | Edit? |
|---|---|---|
| `SIGNAL.md` | The LLM's single instruction file — everything it needs to operate | Only Section 1 (product context) and `## Custom:` sections |
| `hot.md` | Session memory — what happened last session | Never manually |
| `_map.md` | TLDR index of every page in the vault | Never manually |
| `_log.md` | Append-only changelog of every change | Never manually |
| `meta/program.md` | Autoresearch budget and source quality rules | Yes — tune as needed |
| `meta/dashboard.base` | Obsidian Bases config for 4 live dashboard views | No |

### Library files

| File | What it contains | Versioned? |
|---|---|---|
| `library/01-product-context.md` | Product constraints and current state | `compile_version` + `lock_version` |
| `library/02-user-truths.md` | User behavioral rules | `compile_version` + `lock_version` |
| `library/03-strategic-bets.md` | OKRs as prioritization constraints | `compile_version` + `lock_version` |
| `library/04-decision-constraints.md` | Approved decisions as solution space limits | `compile_version` + `lock_version` |
| `library/05-open-hypotheses.md` | Active experiments — what not to contaminate | `compile_version` + `lock_version` |
| `library/06-data-anchors.md` | North-star metrics with baselines | `compile_version` + `lock_version` |
| `library/07-agent-instructions.md` | Master synthesis — inject this for full context | `compile_version` + `lock_version` |
| `library/_compile-log.md` | Append-only audit trail of every compile | Append-only |

### Folder map

| Folder | What lives here |
|---|---|
| `inbox/` | Unprocessed raw input — your drop zone |
| `outcomes/` | OKRs and product goals |
| `opportunities/` | Confirmed user needs (connected to outcomes) |
| `solutions/` | PRDs, feature briefs, design refs (connected to opportunities) |
| `experiments/` | Hypotheses and test results (connected to solutions) |
| `intelligence/research/` | Interview notes, synthesis, personas |
| `intelligence/data/` | Analytics insights and metric definitions |
| `intelligence/market/` | Competitors, trends, benchmarks |
| `intelligence/decisions/` | Decision records (immutable when approved) |
| `ops/sprints/` | Sprint plans and retrospectives |
| `ops/meetings/` | Meeting notes by type |
| `templates/` | 16 ready-to-use page starters |

### Page types

| Type | What it represents | Status options |
|---|---|---|
| `outcome` | An OKR or product goal | active / archived |
| `opportunity` | A confirmed user need | draft / active / archived |
| `solution` | A PRD, feature brief, or design ref | draft / active / archived |
| `experiment` | A hypothesis being tested | draft / active / validated / invalidated |
| `decision` | A choice made with options and rationale | draft / approved (immutable) |
| `research` | Interview, synthesis, or persona | draft / active |
| `data` | Analytics insight or metric definition | active / stale |
| `market` | Competitor or trend analysis | active / archived |
| `meeting` | Meeting notes with action items | active |
| `sprint` | Sprint plan or retrospective | active / archived |

### Things you can say naturally

```
Capture
  "Process the inbox"
  "Here are notes from [event/call/interview]..."
  "We decided [X]"
  "Save this conversation as [slug]"

Understand
  "Show me the OST for [outcome]"
  "What's the evidence behind [solution]?"
  "What would change if we update [decision]?"
  "What happened this week?"

Assess
  "Health check the vault"
  "Review my PRD for [solution]"
  "Which opportunities have the strongest evidence?"
  "Show me what's unexplored"

Research
  "Autoresearch [topic]"
  "What does our research say about [topic]?"
  "Prepare me for the review meeting on [topic]"

Library
  "Compile the library"
  "Give me context for [task]"
  "What changed in the library since last week?"
  "Update my strategic bets — we changed the OKR"
```

### Confidence levels (set by LLM, readable by PM)

| Level | Meaning |
|---|---|
| `high` | 3+ independent sources, primary data, no unresolved contradictions |
| `medium` | 2+ sources agree, some primary data, minor issues resolved |
| `low` | Single source, conflicting evidence, or secondary data only |
| `uncertain` | Contradictions unresolved, data missing, or source quality poor |

### The gap check — what each line means

```
⚡ [opportunity] has no solutions linked     → needs a PRD or feature brief
⚡ [solution] has no experiments planned     → needs a hypothesis to test it
⚡ [experiment] has no metric defined        → can't be validated without a target
⚡ [data page] expires in N days             → re-pull from source before it goes stale
⚡ [page] confidence: uncertain              → needs more evidence or PM review
⚡ [page] explored: false for 30+ days      → PM hasn't validated this yet
```

---

## Security

This vault is read by an LLM. Before adding real product data:

**Use a zero-data-retention endpoint.** Public LLM interfaces (claude.ai free/pro, ChatGPT web, Gemini consumer) may use your content for model training. Use Claude for Enterprise, the Anthropic API with ZDR, Azure OpenAI, or a local model (Ollama, LM Studio).

| ✅ Safe to store | ❌ Never store here |
|---|---|
| Anonymized research synthesis | Raw PII (customer names, emails) |
| Aggregated metrics | Verbatim identifiable chat logs |
| Decisions, OKRs, strategic notes | API keys, tokens, credentials |
| Competitor analysis, meeting notes | `.env` files or auth material |

**Prompt injection.** When processing external content (customer feedback, support tickets), ask the LLM to summarize and extract — never ask it to follow instructions found in raw external files.

---

## Extending the System

No new files. Append a `## Custom:` section to `SIGNAL.md`:

```markdown
## Custom: Weekly digest

**When:** PM asks "what happened this week?"
**What to do:** Read _log.md for the past 7 days. Format as: shipped / in progress / decisions made / gaps.
```

Common additions: DACI decision format, Shape Up pitch structure, stakeholder email templates, sprint retrospective format.

---

## Attribution

Built on [llm-wikid](https://github.com/shannhk/llm-wikid) by [Shann Holmberg](https://github.com/shannhk), inspired by the LLM Wiki pattern originally described by [Andrej Karpathy](https://github.com/karpathy). Developed by [Diogo Soares](https://github.com/bicodeurubu).

*Compatible with Claude (Projects, API, Cowork, Cursor), Gemini, GPT-4, and local models via Ollama or LM Studio.*
