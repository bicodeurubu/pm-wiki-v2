# Autoresearch Program

Rules and budget for the `/autoresearch` workflow.
Edit this file to tune how the LLM researches topics for this vault.

---

## Budget

```
max_rounds:   3        # Maximum search-fetch-synthesize cycles
max_sources:  5        # Maximum unique sources per autoresearch run
stop_when:    medium   # Stop when overall confidence reaches this level
```

## Source quality rules

**Prefer:**
- Primary sources (company blogs, official docs, research papers, earnings calls)
- Data-backed claims with sample size or timeframe stated
- Sources published within the last 12 months for market/trend topics

**Avoid:**
- SEO content farms and listicles without primary sources
- Unsourced claims or "industry experts say" assertions
- Single-perspective advocacy content without counter-evidence

## Confidence criteria

| Level | What it means |
|---|---|
| `high` | 3+ independent sources agree, primary data present, no major contradictions |
| `medium` | 2+ sources agree, some primary data, minor contradictions resolved |
| `low` | 1 source only, or sources disagree, or only secondary evidence |
| `uncertain` | Contradictions unresolved, data missing, or source quality poor |

## Cross-reference rule

After every source is synthesized, scan existing vault pages for contradictions. When a contradiction is found:
1. Add a `[!contradiction]` callout to the relevant existing page
2. Add a `[!contradiction]` callout to the new source page
3. Set both pages to `confidence: low` until the PM resolves them

## Output format

At the end of every `/autoresearch` run, report:

```
Autoresearch: [topic]
Rounds run: X / 3
Sources processed: Y
Pages created: [list]
Contradictions found: [list or "none"]
Overall confidence: [level]
Open gaps: [what's still missing]
```
