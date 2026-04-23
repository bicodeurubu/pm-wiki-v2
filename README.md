# PM-Wiki v2.1

**A product brain built for PMs who think with an LLM — not a system you manage.**

One instruction file. The LLM reads it and operates the entire vault. You talk, it builds the knowledge graph.

---

## What this is

PM-Wiki v2.1 is a vault template for product knowledge management. It organizes everything a PM team knows — decisions, user insights, experiments, market intelligence — into a connected graph that an LLM can read, write, and traverse.

The organizing framework is the **Opportunity Solution Tree** (Teresa Torres). The vault's folder structure *is* the OST. You don't navigate a document library — you traverse a decision tree.

```
outcomes/            Why you're building — OKRs, product goals
  └── opportunities/ What users need — confirmed problems worth solving
        └── solutions/     How you'll solve it — specs, PRDs, design refs
              └── experiments/  Proof — hypotheses, A/B tests, results

intelligence/        Evidence that feeds the tree
  decisions/         Choices made (immutable when approved)
  research/          Interviews, synthesis, personas
  data/              Analytics insights, metric definitions
  market/            Competitors, trends, benchmarks

ops/                 Operational cadence
  sprints/           Sprint plans and retrospectives
  meetings/          Notes by type

inbox/               Drop zone for raw input
  interviews/        Raw interview notes or transcripts
  clippings/         Web articles, market reports
  data/              Analytics exports, CSV files
  competitor/        Screenshots, pricing pages, product tours
  ideas/             Quick thoughts, rough notes

templates/           16 ready-to-use page starters
meta/                System configuration
  program.md         Autoresearch budget and source rules
  dashboard.base     Obsidian Bases: 4 live dashboard views
hooks/               Automation
  update-hot-cache.sh  Stop hook — rewrites hot.md after each session

hot.md               Session memory — auto-maintained
_map.md              TLDR index — auto-maintained
_log.md              Changelog — auto-maintained
SIGNAL.md            The only file the LLM needs to read
```

---

## Features

### Session memory — `hot.md`
The vault remembers what you were doing. A Stop hook runs `claude -p` on the session transcript and rewrites `hot.md` with a compact summary: what was created, what's unresolved, what to pick up next. The next session injects it automatically — no need to re-explain context.

### `/autoresearch [topic]`
Multi-round web research built into the vault. Say *"autoresearch conversational AI trends"* and the LLM runs up to 3 rounds of search, fetches and synthesizes sources, cross-references findings against existing vault pages, and flags contradictions. Budget and source quality rules live in `meta/program.md`.

### `/save [slug]`
Turns any conversation into a filed wiki page. Say *"save this as checkout-decision"* and the LLM classifies the content, creates the right page type in the right folder, links it to existing pages, and commits to git.

### `[!contradiction]` callouts
When two pages conflict, the LLM creates a scannable Obsidian callout block — not buried inline text. Contradictions stay visible in Obsidian's reading view and surface in the dashboard's "Low confidence" filter.

```markdown
> [!contradiction] Conflicts with [[intelligence/data/checkout-funnel-q1]]
> This page says drop-off is 23%. The Q2 re-pull shows 17%. Review before relying on either.
> Added: 2026-04-23
```

### Confidence + explored frontmatter
Every page tracks two signals the LLM manages:
- `confidence: high | medium | low | uncertain` — evidence quality, set by the LLM
- `explored: false` — whether the PM has personally reviewed this page (only the PM sets `true`)

These feed the Obsidian Bases dashboard and the gap check that runs after every interaction.

### Obsidian Bases dashboard — `meta/dashboard.base`
Four live views that surface vault health without manual auditing:

| View | Shows |
|---|---|
| Recent | Pages modified in the last 7 days |
| Low confidence | Pages with `confidence: low` or `uncertain` |
| Unexplored | Pages with `explored: false` (oldest first) |
| Stale | Data pages near or past their freshness window |

### 16 templates — `templates/`
Ready-to-use starters for every page type: opportunity, PRD, feature brief, experiment, decision, user interview, research synthesis, data insight, metric baseline, competitor teardown, meeting notes (alignment / discovery), sprint plan, retrospective, design reference, and diagram.

### Bias check — built into every research page
Every `research`, `market`, and synthesis page requires two sections before it's considered complete:

```markdown
## Counter-arguments
[Opposing viewpoints, contradicting evidence, stakeholder pushback]

## Data gaps
[What's missing, what's unknown, what would raise confidence]
```

Pages without them get `confidence: uncertain` until filled.

### Connection graph
Every page connects to the OST through `[[wikilinks]]` in the body. The LLM enforces connection rules: an opportunity must link to an outcome, a solution to an opportunity, an experiment to the solution it tests. After every interaction it runs a gap check and reports what's structurally missing.

---

## Schema

Every page needs exactly 5 frontmatter fields:

```yaml
---
type: outcome | opportunity | solution | experiment | decision | research | data | market | sprint | meeting
status: draft | active | validated | invalidated | archived
tldr: one sentence
confidence: high | medium | low | uncertain
explored: false
---
```

Connections are `[[wikilinks]]` in the body — no frontmatter arrays to maintain.

---

## Getting started

### 1. Clone

```bash
git clone https://github.com/bicodeurubu/pm-wiki-v2.git my-product-vault
cd my-product-vault
```

### 2. Open in Obsidian

Open the vault folder in Obsidian. Enable the **Graph View** plugin and the **Bases** plugin (community) for the dashboard.

Want to see the system in action first? Open the `Product Example/` folder — it's a fully populated vault for a fictional product (Acme Support AI) with outcomes, opportunities, PRDs, experiments, decisions, and research all connected.

### 3. Configure the product context

Open `SIGNAL.md` and fill in Section 1:

```
Product:  [your product name]
Quarter:  Q2-2026
Core OKR: [one sentence]
PM team:  [names]
```

### 4. (Optional) Set up session memory

Add the Stop hook to Claude Code or Cowork:

```json
// .claude/settings.json
{
  "hooks": {
    "Stop": [{ "type": "command", "command": "bash hooks/update-hot-cache.sh" }]
  }
}
```

Requires: `claude` CLI installed, `jq` installed (`brew install jq`).

### 5. Start talking

Point your LLM at the vault folder and start a conversation:

```
"Here are notes from a user interview about checkout friction..."
→ Research page created, connected to existing opportunities, bias check run

"We decided to cut the export feature from Q2"
→ Decision record created, linked to affected solutions, change logged

"Autoresearch conversational AI trends in B2B support"
→ 3-round web research, source pages created, contradictions flagged

"Save this conversation as onboarding-decision"
→ Conversation classified and filed as a wiki page

"Show me the OST for our main OKR"
→ Mermaid tree generated from the graph

"Health check the vault"
→ Gaps, stale data, low-confidence pages, orphan pages reported
```

Works with: Claude (Projects, API, Cowork, Cursor), Gemini, GPT-4, local models via Ollama or LM Studio.

---

## Security

This vault is designed to be read by an LLM. Before adding real product data:

**Use a zero-data-retention endpoint.** Public LLM interfaces (claude.ai free/pro, ChatGPT web, Gemini consumer) may use your vault contents for model training. Use Claude for Enterprise, the Anthropic API with ZDR opt-out, Azure OpenAI, or a local model.

| ✅ Safe to store | ❌ Never store here |
|---|---|
| Anonymized research synthesis | Raw PII (customer names, emails) |
| Aggregated metrics | Verbatim identifiable chat logs |
| Decisions, OKRs, strategic notes | API keys, tokens, credentials |
| Competitor analysis, meeting notes | `.env` files or auth material |

**Prompt injection.** When processing external content (customer feedback, support tickets), ask the LLM to summarize and extract — never ask it to follow instructions found in raw external files.

---

## Extending the system

Append a `## Custom:` section to `SIGNAL.md`. No new files needed.

```markdown
## Custom: Weekly digest

**When:** PM asks "what happened this week?"
**What to do:** Read _log.md for the past 7 days, format as: shipped / in progress / decisions made / gaps
```

---

## Attribution

Built on [llm-wikid](https://github.com/shannhk/llm-wikid) by [Shann Holmberg](https://github.com/shannhk), inspired by the LLM Wiki pattern originally described by [Andrej Karpathy](https://github.com/karpathy). Developed by [Diogo Soares](https://github.com/bicodeurubu).
