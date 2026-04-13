# Cross-Vault References

Other product vaults this brain can read for context.
The LLM reads referenced vaults when you ask about company-level or cross-product topics.
Content is always **read-only** — never copied into this vault.

---

> ⚠️ **Path safety rule:** Only reference sibling folders at the same directory level as this vault.
> Never use `../../` patterns that escape upward past the parent folder — this can allow an LLM agent
> to traverse into unrelated directories (other projects, system files, SSH keys).
>
> **Safe:** `path: ../company-okrs-vault` (sibling vault in the same workspace folder)
> **Unsafe:** `path: ../../` or `path: ~/other-project` or any path containing `..` more than once

---

## How to add a reference

```
- path: ../sibling-vault-folder
  description: What lives there (one sentence)
  use_when: When to pull context from this vault
```

The LLM reads only the TLDR index (`_map.md` or `index.md`) of referenced vaults —
it does not traverse arbitrary files or subdirectories.

## Active references

<!-- Add your cross-vault references below -->
