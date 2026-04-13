# PM-Wiki v2

**A product brain that thinks with you — not a system you manage.**

---

## The difference from v1

v1 organized knowledge. v2 *reasons* about it.

| v1 | v2 |
|---|---|
| 72 files before first content | 7 files before first content |
| 13 command files to memorize | Speak naturally |
| 15 frontmatter fields per page | 3 fields per page |
| Skills, agents, commands as separate files | Everything in one SIGNAL.md |
| OST generated on demand | OST is the folder structure |
| Reactive — acts when you run commands | Proactive — surfaces gaps automatically |
| Templates tell you what to fill | Examples show you what good looks like |

The philosophy: **give the LLM principles, not procedures.** A good LLM doesn't need a 10-step script to process a user interview — it needs to understand what a product brain cares about.

---

## How it works

The vault has one instruction file — `SIGNAL.md`. It tells the LLM:
- How this vault is organized (the OST structure)
- What every page needs (3 fields + wikilinks)
- What good content looks like (concrete examples)
- What to always do (gap detection, logging, linking)
- What you can ask for (in plain language)

Everything else is your product knowledge.

---

## Getting started

### 1. Clone and open

```bash
git clone https://github.com/bicodeurubu/pm-wiki-v2.git my-product-vault
cd my-product-vault
```

**Want to see how it works first?**
The repository includes a `Product Example/` folder with a fully populated dummy vault (Acme Support AI).
1. Open the `Product Example/` folder in Obsidian.
2. Point your LLM at the `Product Example/` folder and try asking: *"What are the active opportunities?"* or *"Show me the OST"*.

**Ready to start your own?**
Open the root folder (the empty template) in Obsidian. Enable the Graph View plugin — it will become your primary navigation tool as the vault grows.

### 2. Fill in the product context

Open `SIGNAL.md` and fill in Section 1:

```
Product:  Your product name
Quarter:  Q2-2026
Core OKR: One sentence describing the main outcome this quarter
PM team:  Names of PMs using this vault
```

### 3. Point your LLM at the vault

Open the vault folder with your preferred LLM interface. The LLM reads `SIGNAL.md` first — everything it needs to operate is there.

Works with: Claude (Projects or API), Cursor, Continue, Zed AI, LM Studio, Ollama, Gemini — any LLM that can read a folder.

### 4. Start talking

You don't run commands. You talk.

```
"Here are my notes from a user interview about onboarding friction..."
→ LLM creates a research page, finds connections, updates the map, flags gaps

"We decided to delay the export feature to Q3 because of eng capacity"
→ LLM creates a decision record, links it to affected solutions, logs the change

"Show me the OST for our main OKR"
→ LLM traverses the graph and generates a Mermaid tree

"Prepare me for tomorrow's spec review on the onboarding flow"
→ LLM pulls relevant pages, surfaces gaps, lists open questions
```

### 5. Drop files when needed

For files (PDFs, exports, screenshots descriptions, raw notes), use `inbox/`:

```
inbox/
├── user-interview-transcript-may-12.md
├── checkout-funnel-export-q1.csv
└── competitor-teardown-notes.md
```

Then ask: *"Process what's in inbox/"* — the LLM classifies, creates wiki pages, builds connections.

---

## The vault structure = the OST

```
outcomes/        Why you're building — OKRs, product goals
  │
  └──► opportunities/    What users need — confirmed problems worth solving
         │
         └──► solutions/       How you'll solve it — specs, PRDs, design refs
                │
                └──► experiments/   Proof — hypotheses, A/B tests, results

intelligence/    Evidence that feeds the tree
  decisions/     Choices made (immutable when approved)
  research/      Interviews, synthesis, personas
  data/          Analytics insights, metric definitions
  market/        Competitors, trends, benchmarks

ops/             Operational cadence
  sprints/       Sprint plans and retrospectives
  meetings/      Notes by type (discovery, alignment, review)

inbox/           Drop zone — anything goes here
_map.md          Auto-maintained TLDR index
_log.md          Auto-maintained changelog
```

You navigate the OST, not a document library. The graph view in Obsidian makes this visual.

---

## The only schema you need

```yaml
---
type: outcome | opportunity | solution | experiment | decision | research | data | market | sprint | meeting
status: draft | active | validated | invalidated | archived
tldr: one sentence
---
```

Connections are `[[wikilinks]]` in the body — not frontmatter arrays. The graph handles the rest.

---

## What the LLM always does (without being asked)

- **Links pages** — every new page is connected to related existing pages via wikilinks
- **Updates the map** — `_map.md` stays current with TLDRs of every page
- **Logs changes** — `_log.md` records every create and update
- **Detects gaps** — after every interaction, reports what's structurally missing
- **Flags stale data** — when a data insight's freshness window closes, affected solutions are notified
- **Commits to git** — every change is versioned automatically

---

## What you can ask (examples)

**Capture**
> "Here are my notes from 3 user interviews about checkout friction..."
> "I dropped files in inbox/"
> "We just decided to cut the export feature from Q2 scope"

**Understand**
> "Show me the OST for [outcome]"
> "What's the evidence behind [solution]?"
> "What would break if we change [decision]?"
> "What happened this week?"

**Assess**
> "Review my PRD for [solution]"
> "Health check the vault"
> "Which opportunities have the strongest evidence?"

**Synthesize**
> "What should we focus on next quarter?"
> "Prepare me for my review meeting on [topic]"
> "What does our research say about [user behavior]?"

---

## Extending the system

No new files. No skill templates. Append a `## Custom:` section to `SIGNAL.md`:

```markdown
## Custom: Weekly digest

When asked "what happened this week?", read _log.md for the past 7 days
and format a PM standup: what shipped, what's in progress, decisions made, gaps.
```

That's it. The LLM picks it up immediately.

---

## Cross-vault context

Edit `context.md` to reference other product vaults. The LLM reads them when you ask about company-level topics — without copying content into this vault.

---

## For teams using git

```bash
# Pull before your session
git pull origin main

# The LLM commits as it works — push when you're ready
git push origin main
```

Commit format used automatically:
- `feat(opportunity):` new page created
- `chore(map):` index or log updated
- `fix(graph):` broken link repaired

---

## Two versions, two philosophies

| | v1 | v2 |
|---|---|---|
| **Mental model** | Filing cabinet | Thinking partner |
| **Learning curve** | High — many files and conventions | Low — read SIGNAL.md, start talking |
| **Best for** | Teams who want explicit process control | Teams who want to move fast with AI |
| **Scales by** | Adding more files and commands | Adding sections to SIGNAL.md |
| **OST** | Generated on demand | Embedded in structure |

Both versions exist. Use the one that fits your team. Study the other to understand the tradeoffs.
