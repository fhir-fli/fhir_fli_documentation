/**
 * Creating a sidebar enables you to:
 - create an ordered group of docs
 - render a sidebar for each doc of that group
 - provide next/previous navigation

 The sidebars can be generated from the filesystem, or explicitly defined here.

 Create as many sidebars as you want.
 */

// @ts-check

// @ts-check

/** @type {import('@docusaurus/plugin-content-docs').SidebarsConfig} */
const sidebars = {
  tutorialSidebar: [
    'getting-started',
    'fhir_r4',
    'fhir_r4_at_rest',
    'fhir_r4_db',
    'fhir_r4_bulk',
    'fhir_r4_path',
    'fhir_r4_utils',
    {
      type: 'category',
      label: 'Guides',
      items: [
        'guides/installation',
        'guides/basic-usage',
      ],
    },
  ],
};

module.exports = sidebars;
