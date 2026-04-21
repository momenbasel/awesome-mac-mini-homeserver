# Contributing

Thanks for considering a contribution. This list only accepts tools that fit a Mac mini home server use case.

## Entry format

```
- [Name](https://url) - Sentence-case description ending with a period. `[TAG]`
```

Rules:

1. Alphabetical order within each subsection (case-insensitive)
2. HTTPS URLs only
3. Description must be one sentence and end with a period
4. Sentence case, no marketing fluff
5. Add the right tags from the Legend in the README
6. No duplicate links

## Tag legend

- `[AS]` Apple Silicon only
- `[Intel]` Intel Mac only
- `[U]` Universal
- `[D]` Runs via Docker
- `[N]` macOS native
- `[P]` Paid or freemium

## Scope

Accepted: tools useful on a 24/7 Mac mini home server - agents, self-hosted services, media, smart home, automation, monitoring, networking, power, CI/CD runners.

Rejected: Windows-only apps, deprecated projects, GUI-only apps with no headless use case, duplicates, self-promotion without merit.

## Submission checklist

- [ ] My entry is in the correct subsection
- [ ] Alphabetical order preserved
- [ ] Description is one sentence with a period
- [ ] URL is HTTPS and resolves
- [ ] Tags applied
- [ ] `awesome-lint` passes locally: `npx awesome-lint`
- [ ] No broken links

## Local verification

```bash
npx awesome-lint
npx markdown-link-check README.md
```

## Code of conduct

This project follows the [Contributor Covenant](https://www.contributor-covenant.org/version/2/1/code_of_conduct/). Be kind, assume good intent, no harassment.
