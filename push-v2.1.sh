#!/bin/bash
# push-v2.1.sh — Commit e push do PM-Wiki v2.1 para o GitHub
# Execute na pasta PM-Wiki-v2:
#   bash push-v2.1.sh

set -e

echo "→ Limpando lock files..."
rm -f .git/index.lock .git/HEAD.lock .git/packed-refs.lock

echo "→ Adicionando arquivos..."
git add -A

echo "→ Criando commit..."
git commit -m "feat(wiki): release v2.1

- hot.md + hooks/update-hot-cache.sh: session memory via Stop hook
- /autoresearch: multi-round web research with budget control (meta/program.md)
- /save: turns any conversation into a filed wiki page
- [!contradiction] callouts: scannable conflict blocks
- confidence + explored frontmatter: 5-field schema
- meta/dashboard.base: Obsidian Bases (Recent, Low conf, Unexplored, Stale)
- 16 templates adapted for v2.1 schema
- Categorized inbox sub-folders with README.md per folder
- Bias check required on research/market/synthesis pages
- README.md rewritten to focus on features and usage
- SIGNAL.md updated with all new behaviors

Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>"

echo "→ Fazendo push para GitHub..."
git push origin main

echo ""
echo "✓ PM-Wiki v2.1 publicado em:"
echo "  https://github.com/bicodeurubu/pm-wiki-v2"
