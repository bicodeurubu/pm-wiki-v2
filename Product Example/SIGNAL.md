# SIGNAL — Acme Support AI Product Brain

> This is the only file you need to read to operate this vault.
> Everything else is content — this is the intelligence layer.

---

## 1. What this is

This vault is the **product brain** for **Acme Support AI**. It holds every decision, user insight, experiment, and piece of market knowledge — connected in a living graph.

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

**Current product context:**
```
Product:  Acme Support AI — conversational AI for B2B customer support
Quarter:  Q2-2026
Core OKR: Increase chatbot autonomous resolution rate from 41% to 60% by end of Q2
PM team:  Ana Souza, Bruno Lima
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
- `confidence` — set by the LLM based on evidence quality. The PM may adjust after review.
- `explored: false` — always set by the LLM. **Only the PM sets `true`** after personally validating the content.

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

*(See the pages in this example vault — they follow these patterns.)*

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
2. If the updated page is a `decision` (approved), `outcome`, or `data` insight: add a visible flag to all pages that link to it
3. Commit: `chore(type): update [page title]`

### After every interaction — gap check
Always report what's structurally missing. Format:

```
⚡ Gaps detected:
• [opportunity-name] has no solutions linked yet
• [solution-name] has no experiments planned
• [experiment-name] has no metric defined
```

If no gaps: `✅ No structural gaps detected.`

### Decisions are immutable when approved
When a page has `type: decision` and `status: approved`, never edit its body.

### Git
Commit format: `type(area): description`. Never `git push` — that's always the PM's decision.

---

## 5. Behavioral discipline

Declare before acting. Create minimum pages. Never rewrite evidence. Verify completion before reporting done.

---

## 6. What you can ask me

**Capture:** "Here are my notes from a user interview...", "Process what's in inbox/", "We decided to delay X to Q3"

**Understand:** "Show me the OST for [outcome]", "What's the evidence behind [solution]?", "What happened this week?"

**Assess:** "Review my PRD for [solution]", "Health check the vault", "Which opportunities have strongest evidence?"

**Synthesize:** "What should we focus on next quarter?", "Prepare me for review meeting on [topic]"

---

## 7. Extending this system

No new files needed. Append a `## Custom:` section to this file:

```markdown
## Custom: [Behavior Name]

**When:** [the situation that triggers this]
**What to do:** [plain language description]
**Example:** [one concrete input → output]
```

---

*Compatible with any LLM that can read this folder: Claude, Gemini, GPT-4, local models via LM Studio, Ollama, Cursor, Continue, Zed AI.*
