# PM-Wiki v2

**A product brain that thinks with you — not a system you manage.**

---

## The difference from v1

PM-Wiki v1 and v2 are not sequential releases — they are different answers to the same problem, built on different philosophies.

**PM-Wiki v1 — structured control**

v1 is opinionated by design. It defines a strict schema (15 frontmatter fields), a full command system, separate agent personas, reusable skill modules, and explicit rules that govern every write. The LLM follows a procedure. Every connection is bidirectional and validated. Every change is propagated deterministically. The system behaves the same way regardless of which model or person is using it.

v1 is the right choice when you want maximum traceability, predictable behavior at team scale, or an environment that requires auditability. More control means more setup — that's the trade.

**PM-Wiki v2 — open inference**

v2 gives the LLM principles, not procedures. One instruction file (`SIGNAL.md`). Three frontmatter fields. No commands — you talk. The folder structure *is* the OST. Extending the system means appending a section to a single file.

v2 trusts that a capable LLM understands what a product brain cares about without being scripted. It's lighter, faster to start, and more creative. The tradeoff is that behavior is less deterministic — judgment is delegated to the model.

| | v1 | v2 |
|---|---|---|
| **Philosophy** | Explicit procedures for the LLM | Principles, trust the LLM to infer |
| **Schema** | 15 frontmatter fields, strict | 3 fields, loose |
| **Interface** | 13 commands | Plain conversation |
| **Agents / Skills** | Separate files, explicit personas | Embedded in one instruction file |
| **Setup cost** | Higher — more files, more conventions | Lower — fill in one file and talk |
| **Predictability** | High — rules enforced on every write | Medium — depends on LLM judgment |
| **Best for** | Teams wanting process control and auditability | Individuals or teams wanting speed and flexibility |

Neither version is better. Use whichever fits your context. Both are actively maintained.

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

## Security considerations

Wiki-PM is designed to be read by an LLM. That creates risks that a plain folder of notes doesn't have. Read these before you put real product data into your vault.

### LLM data retention (DLP / LGPD / GDPR)

**If you use a public or personal LLM interface** (claude.ai free/pro, ChatGPT web, Gemini consumer), your vault contents may be used for model training. This is a direct violation of most company data policies and potentially LGPD/GDPR if the vault contains customer-related data.

Before pointing an LLM at a vault with real product data, use one of:
- **Claude for Enterprise** (zero data retention by contract)
- **Anthropic API / OpenAI API** (opt-out of training available — verify your account settings)
- **Azure OpenAI** (zero data retention by default in enterprise tiers)
- **Local model** (Ollama, LM Studio — never leaves your machine)

**What belongs in this vault and what doesn't:**

| ✅ Safe | ❌ Never store here |
|---|---|
| Anonymized research synthesis | Raw PII (customer names, emails, phone numbers) |
| Aggregated metrics | Verbatim identifiable chat/support logs |
| Strategic decisions and OKRs | API keys, tokens, credentials |
| Competitor analysis and meeting notes | `.env` files or auth material of any kind |

### Cross-vault path safety

When configuring `context.md`, only reference sibling vaults at the same directory level. Never use `../../` paths that escape the workspace. See `context.md` for the full rule.

### Prompt injection awareness

When ingesting external content (customer feedback, support tickets, raw interview transcripts), treat those inputs as untrusted. Ask the LLM to **summarize and extract** — never ask it to follow instructions found within external files.

---

## Two versions, two philosophies

See [The difference from v1](#the-difference-from-v1) at the top of this document for the full comparison. The short version: v1 is more structured, more controlled, more files — built for teams that want explicit process. v2 is lighter, more open, relies more on LLM inference — built for teams that want to move fast and think out loud. Neither is better. They fit different contexts.

---

## Attribution

PM-Wiki v2 builds on **[PM-Wiki v1](https://github.com/bicodeurubu/pm-wiki-v1)** by [Diogo Soares](https://github.com/bicodeurubu), which is a fork of **[llm-wikid](https://github.com/shannhk/llm-wikid)** by [Shann Holmberg](https://github.com/shannhk), which is itself inspired by the LLM Wiki pattern originally described by [Andrej Karpathy](https://github.com/karpathy).

v2 reimagines the system architecture: replacing the command/agent/skill file hierarchy with a single `SIGNAL.md` instruction file, embedding the Opportunity Solution Tree in the folder structure itself, and reducing the schema from 15 frontmatter fields to 3.

If you fork this repository, please maintain this attribution chain.
