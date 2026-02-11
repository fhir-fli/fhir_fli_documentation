# FHIR-FLI Documentation

Documentation site for the [FHIR-FLI](https://github.com/fhir-fli) project — Dart/Flutter libraries for working with FHIR (Fast Healthcare Interoperability Resources). Built with [Docusaurus 3](https://docusaurus.io/) and deployed to GitHub Pages.

**Live site:** https://fhir-fli.github.io/fhir_fli_documentation/

## What's Documented

- **FHIR R4** — Core resources, primitive types, serialization, enums, polymorphic types
- **FHIR at Rest** — REST client for FHIR servers (requests, parameters)
- **FHIR DB** — Local encrypted Hive database
- **FHIR Bulk** — Bulk data import/export (NDJSON)
- **FHIRPath** — FHIRPath query language
- **FHIR Validation** — Resource validation
- **FHIR Mapping** — FHIR Mapping Language parsing and engine
- **FHIRPath Demo** — Interactive Flutter web app for FHIRPath queries
- **Cicada Vaccination IG** — Immunization forecasting Implementation Guide based on CDC CDSi

## Development

```bash
npm install            # Install dependencies
npm start              # Dev server with hot reload
npm run build          # Production build to /build
npm run serve          # Serve production build locally
```

## Linting and Formatting

```bash
npm run format         # Format with Prettier
npm run format:check   # Check formatting
npm run lint           # ESLint
npm run typecheck      # TypeScript type checking
```

## Deployment

Pushing to `main` automatically builds and deploys to the `gh-pages` branch via GitHub Actions.

## Project Structure

```
docs/                  # Markdown documentation files
src/pages/             # Custom React/TypeScript pages
src/css/               # Theme customization
static/fhir_path_demo/ # Pre-built Flutter FHIRPath demo
static/cicada_ig/      # Pre-built Cicada Vaccination IG
sidebars.js            # Sidebar navigation (manually defined)
docusaurus.config.js   # Site configuration
```
