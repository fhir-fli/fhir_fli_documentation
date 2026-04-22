# FHIR-FLI Documentation

Documentation site for the [FHIR-FLI](https://github.com/fhir-fli) project — Dart/Flutter libraries for working with FHIR (Fast Healthcare Interoperability Resources). Built with [Jaspr](https://jaspr.site) (`jaspr_content`) and deployed to GitHub Pages.

**Live site:** https://fhir-fli.github.io/fhir_fli_documentation/

## What's documented

- **FHIR R4** — core resources, primitive types, serialization, polymorphic types
- **FHIR at Rest** — REST client for FHIR servers
- **FHIR Auth** — SMART on FHIR authentication
- **FHIR DB / Bulk / Path / Validation / CQL / Mapping** — companion packages
- **Applications** — Botswana AMR IG, Cicada (immunization forecasting), Drosophila (clinical trial matching), FHIR ANT (mobile FHIR server)
- Embedded Flutter web demos for FHIRPath, Cicada, Drosophila, Botswana AMR, and the Cicada Vaccination IG

## Development

```bash
dart pub global activate jaspr_cli   # one-time
cd jaspr
dart pub get
$HOME/.pub-cache/bin/jaspr serve     # dev server with hot-reload at localhost:8080
$HOME/.pub-cache/bin/jaspr build     # static output to jaspr/build/jaspr/
```

`content/_data/site.yaml` ships with `base: /` so the dev server works against the localhost root. The deploy workflow rewrites `base` to `/fhir_fli_documentation/` before building for production.

## Deployment

Pushing to `main` triggers `.github/workflows/deploy.yml`, which builds the site and publishes `jaspr/build/jaspr/` to the `gh-pages` branch.

## Project structure

```
jaspr/
├── content/
│   ├── _data/site.yaml        # title, base URL, favicon, social links
│   ├── index.md, about.md, contact.md
│   └── docs/                  # 45 doc pages, organised by topic
├── lib/
│   ├── main.server.dart       # ContentApp wiring: header, sidebar groups, theme
│   ├── main.client.dart
│   └── components/            # CollapsibleSidebar, SiteFooter
└── web/
    ├── images/                # FHIR-FLI logos
    └── <demo>                 # Symlinks → ../../static/<demo> (Flutter web bundles)

static/                        # Pre-built Flutter web apps embedded as iframes
.github/workflows/             # deploy.yml (push → main) and main.yaml (PR check)
```
