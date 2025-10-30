/**
 * Creating a sidebar enables you to:
 - create an ordered group of docs
 - render a sidebar for each doc of that group
 - provide next/previous navigation

 The sidebars can be generated from the filesystem, or explicitly defined here.

 Create as many sidebars as you want.
 */

// @ts-check

/** @type {import('@docusaurus/plugin-content-docs').SidebarsConfig} */
const sidebars = {
  tutorialSidebar: [
    'getting-started',
    {
      type: 'category',
      label: 'FHIR R4b',
      items: [
        'core/fhir_r4',
        'core/basic_object',
        'core/serialization',
        'core/class_structure',
        'core/polymorphic_types',
        'core/primitive_types',
        'core/enums',
        'core/migration',
      ],
    },
    {
      type: 'category',
      label: 'FHIR at Rest',
      items: [
        'at_rest/fhir_r4_at_rest',
        'at_rest/restful_requests',
        'at_rest/restful_parameters',
      ],
    },
    {
      type: 'category',
      label: 'FHIR Auth',
      items: [
        'auth/fhir_r4_auth',
        'auth/installation',
        'auth/standalone-launch',
        'auth/ehr-launch',
        'auth/backend-services',
        'auth/session-management',
        'auth/token-management',
        'auth/security',
        {
          type: 'category',
          label: 'Platform Setup',
          items: [
            'auth/platform/ios',
            'auth/platform/android',
            'auth/platform/web',
            'auth/platform/desktop',
          ],
        },
        {
          type: 'category',
          label: 'Server Integration',
          items: [
            'auth/servers/epic',
            'auth/servers/cerner',
            'auth/servers/smart-sandbox',
            'auth/servers/google-healthcare',
          ],
        },
        'auth/troubleshooting',
        'auth/migration',
      ],
    },
    'fhir_r4_db',
    'fhir_r4_bulk',
    'fhir_r4_path',
    {
      type: 'category',
      label: 'FHIR Mapping',
      items: [
        'mapping/fhir_mapping',
        'mapping/fhirmap_parsing',
        'mapping/fhir_mapping_engine',
      ],
    },
    {
      type: 'category',
      label: 'Demos',
      items: [
        'demos/fhir_path_demo',
      ],
    },
  ],
};

module.exports = sidebars;