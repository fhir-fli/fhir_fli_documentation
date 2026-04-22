# CLAUDE.md

# 🛑🛑🛑 ABSOLUTE RULE #1 — INCREMENTAL OUTPUT — NO EXCEPTIONS — READ THIS FIRST 🛑🛑🛑

## **EVERY SCRIPT WRITES RESULTS TO DISK INCREMENTALLY. EVERY ITERATION. NO EXCEPTIONS. NEVER.**

Violated multiple times; **the user has been furious every single time**. Applies to EVERY script — regardless of runtime, regardless of how "throwaway" it feels. No exceptions.

**If you think "this is just a quick diagnostic, I don't need to write incrementally" — THAT THOUGHT IS THE VIOLATION.** Stop. Open the file. Write incrementally. NOW.

**MANDATORY pattern:**
```python
fh = open(out_path, 'w'); fh.write('header\n')
for item in items:
    result = compute(item)
    fh.write(f'{result}\n'); fh.flush()
    print(f'{item}: {result}', flush=True)
fh.close()
```

**FORBIDDEN:** `results.append(...)` accumulators with a final `json.dumps`; `print()` without `flush=True`; bash pipes that buffer (`| head`, `| tail`, `| tee`, `| grep`); single `>` redirect with no incremental writes; `concurrent.futures` final-collection patterns; importing/running ANY existing script WITHOUT first opening it to check for buffering.

**Before running any existing script: READ IT.** If it buffers, fix it first. No exceptions.

The user has been burned by scripts that ran 11+ minutes, crashed at the end, and left zero output. **Buffered output is data loss waiting to happen.** Apply every time.

---

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Docusaurus 3 documentation site for the FHIR-FLI project (Dart/Flutter libraries for FHIR healthcare data standards). Deployed as a static site to GitHub Pages at `https://fhir-fli.github.io/fhir_fli_documentation/`.

## Commands

```bash
npm install            # Install dependencies (first time)
npm start              # Dev server with hot reload
npm run build          # Production build to /build
npm run serve          # Serve production build locally
npm run format         # Format with Prettier
npm run format:check   # Check formatting (CI uses this)
npm run lint           # ESLint
npm run typecheck      # TypeScript type checking
npm run clear          # Clear Docusaurus cache
```

## CI/CD

- **PRs** (`main.yaml`): runs format:check, lint, and build
- **Push to main** (`deploy.yml`): builds and auto-deploys to `gh-pages` branch

## Architecture

### Documentation Content

All docs live in `docs/` as Markdown files. Sidebar navigation is manually defined in `sidebars.js` (not auto-generated from filesystem). The `docs/auth/` directory exists but is **excluded** from the build via `docusaurus.config.js` (`exclude: ['auth/**']`).

Doc categories map to FHIR-FLI packages:
- `docs/core/` — fhir_r4 core concepts (types, serialization, enums)
- `docs/at_rest/` — fhir_r4_at_rest REST client
- `docs/mapping/` — fhir_r4_mapping language
- `docs/demos/` — interactive demos
- Top-level docs: fhir_r4_db, fhir_r4_bulk, fhir_r4_path, fhir_r4_validation

### Custom Pages

`src/pages/` contains standalone React/TypeScript pages (index, about, contact). The homepage (`index.tsx`) redirects to `/docs`.

### Embedded Flutter Demo

`docs/fhir_path_demo/` and `static/fhir_path_demo/` contain a pre-compiled Flutter web app for interactive FHIRPath queries. These are build artifacts — do not edit them directly.

### Key Configuration

- `docusaurus.config.js` — site config, navbar, footer, Prism languages (bash, dart, yaml)
- `sidebars.js` — sidebar structure (must be updated when adding/removing docs)
- `src/css/custom.css` — theme colors and GitHub icon styling
- **Broken links**: set to `throw` (strict) — builds will fail on broken internal links

### Style

- Prettier with single quotes (`.prettierrc`)
- ESLint with `@docusaurus/eslint-plugin` recommended rules

## Adding New Documentation

1. Create a `.md` file in the appropriate `docs/` subdirectory
2. Add the doc ID to `sidebars.js` in the correct category
3. Verify with `npm run build` (broken links will cause build failure)
