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

Documentation site for the FHIR-FLI project (Dart/Flutter libraries for FHIR
healthcare data standards). Built with **Jaspr** (`jaspr_content`) — the old
Docusaurus setup is gone. Deployed as a static site to GitHub Pages at
`https://fhir-fli.github.io/fhir_fli_documentation/`.

## Commands

```bash
dart pub global activate jaspr_cli    # one-time
cd jaspr
dart pub get
$HOME/.pub-cache/bin/jaspr serve      # dev server with hot reload at localhost:8080
$HOME/.pub-cache/bin/jaspr build      # static output to jaspr/build/jaspr/
```

## CI/CD

Pushing to `main` triggers `.github/workflows/deploy.yml`, which builds the
site and publishes `jaspr/build/jaspr/` to the `gh-pages` branch.
`content/_data/site.yaml` ships with `base: /` for local dev; the deploy
workflow rewrites it to `/fhir_fli_documentation/` for production.

## Architecture

### Documentation Content

All docs live in `jaspr/content/docs/` as Markdown files. Sidebar navigation
is manually defined in `jaspr/lib/main.server.dart` (`SidebarGroup` /
`SidebarLink`) — update it when adding or removing pages.

Doc categories map to FHIR-FLI packages:
- `core/` — fhir_r4 core concepts (types, serialization, enums, migration)
- `at_rest/` — fhir_r4_at_rest REST client
- `auth/` — fhir_r4_auth SMART on FHIR
- `mapping/` — fhir_r4_mapping (FHIR Mapping Language)
- `demos/` — interactive demos (FHIRPath, FHIR Mapping)
- Top-level: fhir_r4_db, fhir_r4_bulk, fhir_r4_path, fhir_r4_cql,
  fhir_r4_validation, ucum, index
- App docs: `fhirant/`, `cicada/`, `drosophila/`, `bw_amr_ig/`

### 🔗 LINK RULE (critical)

The rendered pages carry a `<base href>` (`/` locally,
`/fhir_fli_documentation/` in production), and **markdown links pass through
verbatim** — they are NOT rewritten relative to the page. Every internal link
in page bodies must therefore be **base-relative with no leading slash and the
full `docs/` prefix**, exactly like the sidebar: `](docs/core/fhir_r4)`,
`](docs/mapping/fhir_mapping)`. Never `](fhir_r4_db)`, never
`](../core/fhir_r4)`, never a leading `/`.

Known framework quirk: jaspr_content's auto-generated heading-anchor links use
absolute `/docs#...` paths that ignore the production base path — do not
imitate them in content.

### Embedded Flutter Demos

`jaspr/web/` holds pre-compiled Flutter web apps embedded via iframes (the
old repo-root `static/` was an unreferenced Docusaurus-era duplicate and was
removed — the build serves ONLY `jaspr/web/`):
`fhir_path_demo/` (source: fhir_r4 monorepo `packages/fhir_path_demo`),
`fhir_mapping_demo/` (source: `packages/fhir_mapping_demo`), plus
`drosophila/`, `cicada_demo/`, `cicada_ig/`, `bw_amr_ig/`. These are build
artifacts — rebuild them in their source repos with
`flutter build web --release --base-href="/fhir_fli_documentation/<dir>/"`
and copy `build/web/` here; do not edit them directly.

## Adding New Documentation

1. Create a `.md` file under `jaspr/content/docs/` (front-matter: `title:`).
2. Add a `SidebarLink` in `jaspr/lib/main.server.dart`.
3. Follow the LINK RULE above for any internal links.
4. Verify with `jaspr build` (all routes must generate).
