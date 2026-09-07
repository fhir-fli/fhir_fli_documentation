---
title: Orbweaver Playground
---

Orbweaver is the clinical quick-reference app behind *Grey's Quick Reference*, the WHO
*Pocket Book of Hospital Care for Children* and the WVEMS protocols. Every page it draws
is a YAML **topic** file; the app is only a renderer. This playground is a Flutter web
build of that renderer: paste a topic on the left and the right-hand pane shows exactly
what the app would draw, plus the verdict of the published JSON Schema.

How to use it:

- **Load an example** from the drop-down. The fifteen examples are real pages from the
  bundled books and between them use every block type (prose, tables, six flowchart
  variants, drug and procedure cards, images, layout grids, and the interactive formula,
  score and conversion blocks).
- **Edit the YAML** and press **Render**. A green bar means the file matches the schema. An
  amber bar lists schema problems by path — the page still renders, because that is what
  the app does with keys it does not know: it ignores them silently, which is the reason
  the schema exists. A red bar means the app cannot read the file at all.
- **Links**: `#anchor` links inside the topic scroll; `topic:` links to other pages render
  inert here because there is no library to resolve them.

### Writing a topic with an LLM

The schema is small enough to hand to a model. Give it
[`topic.schema.json`](orbweaver/schema/topic.schema.json) (about 75 KB), one or two of
the example topics from the drop-down, and a description of the page you want; paste the
YAML it returns into the playground. The amber bar tells you what to send back. The
[authoring reference](docs/orbweaver/orbweaver_authoring) explains every block in prose.

Schemas: [topic](orbweaver/schema/topic.schema.json) ·
[book](orbweaver/schema/book.schema.json) ·
[formulary](orbweaver/schema/formulary.schema.json) ·
[index](orbweaver/schema/index.schema.json).

Here's the live playground [link for full screen](https://fhir-fli.github.io/fhir_fli_documentation/orbweaver_demo/):

<iframe
  src="orbweaver_demo/index.html"
  sandbox="allow-scripts allow-same-origin allow-popups"
  style="width: 100%; height: 800px; border: none;">
</iframe>
