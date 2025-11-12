import React from 'react';
import ComponentCreator from '@docusaurus/ComponentCreator';

export default [
  {
    path: '/fhir_fli_documentation/about',
    component: ComponentCreator('/fhir_fli_documentation/about', 'e7c'),
    exact: true
  },
  {
    path: '/fhir_fli_documentation/contact',
    component: ComponentCreator('/fhir_fli_documentation/contact', '90a'),
    exact: true
  },
  {
    path: '/fhir_fli_documentation/mayjuun',
    component: ComponentCreator('/fhir_fli_documentation/mayjuun', 'ffc'),
    exact: true
  },
  {
    path: '/fhir_fli_documentation/docs',
    component: ComponentCreator('/fhir_fli_documentation/docs', 'ba7'),
    routes: [
      {
        path: '/fhir_fli_documentation/docs',
        component: ComponentCreator('/fhir_fli_documentation/docs', '392'),
        routes: [
          {
            path: '/fhir_fli_documentation/docs',
            component: ComponentCreator('/fhir_fli_documentation/docs', 'f44'),
            routes: [
              {
                path: '/fhir_fli_documentation/docs',
                component: ComponentCreator('/fhir_fli_documentation/docs', 'bc8'),
                exact: true,
                sidebar: "tutorialSidebar"
              },
              {
                path: '/fhir_fli_documentation/docs/at_rest/fhir_r4_at_rest',
                component: ComponentCreator('/fhir_fli_documentation/docs/at_rest/fhir_r4_at_rest', '22f'),
                exact: true,
                sidebar: "tutorialSidebar"
              },
              {
                path: '/fhir_fli_documentation/docs/at_rest/restful_parameters',
                component: ComponentCreator('/fhir_fli_documentation/docs/at_rest/restful_parameters', '8e0'),
                exact: true,
                sidebar: "tutorialSidebar"
              },
              {
                path: '/fhir_fli_documentation/docs/at_rest/restful_requests',
                component: ComponentCreator('/fhir_fli_documentation/docs/at_rest/restful_requests', 'f64'),
                exact: true,
                sidebar: "tutorialSidebar"
              },
              {
                path: '/fhir_fli_documentation/docs/core/basic_object',
                component: ComponentCreator('/fhir_fli_documentation/docs/core/basic_object', '9fc'),
                exact: true,
                sidebar: "tutorialSidebar"
              },
              {
                path: '/fhir_fli_documentation/docs/core/class_structure',
                component: ComponentCreator('/fhir_fli_documentation/docs/core/class_structure', '804'),
                exact: true,
                sidebar: "tutorialSidebar"
              },
              {
                path: '/fhir_fli_documentation/docs/core/enums',
                component: ComponentCreator('/fhir_fli_documentation/docs/core/enums', 'a35'),
                exact: true,
                sidebar: "tutorialSidebar"
              },
              {
                path: '/fhir_fli_documentation/docs/core/fhir_r4',
                component: ComponentCreator('/fhir_fli_documentation/docs/core/fhir_r4', '57a'),
                exact: true,
                sidebar: "tutorialSidebar"
              },
              {
                path: '/fhir_fli_documentation/docs/core/migration',
                component: ComponentCreator('/fhir_fli_documentation/docs/core/migration', '50a'),
                exact: true,
                sidebar: "tutorialSidebar"
              },
              {
                path: '/fhir_fli_documentation/docs/core/polymorphic_types',
                component: ComponentCreator('/fhir_fli_documentation/docs/core/polymorphic_types', '027'),
                exact: true,
                sidebar: "tutorialSidebar"
              },
              {
                path: '/fhir_fli_documentation/docs/core/primitive_types',
                component: ComponentCreator('/fhir_fli_documentation/docs/core/primitive_types', 'f94'),
                exact: true,
                sidebar: "tutorialSidebar"
              },
              {
                path: '/fhir_fli_documentation/docs/core/serialization',
                component: ComponentCreator('/fhir_fli_documentation/docs/core/serialization', '328'),
                exact: true,
                sidebar: "tutorialSidebar"
              },
              {
                path: '/fhir_fli_documentation/docs/demos/fhir_path_demo',
                component: ComponentCreator('/fhir_fli_documentation/docs/demos/fhir_path_demo', '2f0'),
                exact: true,
                sidebar: "tutorialSidebar"
              },
              {
                path: '/fhir_fli_documentation/docs/fhir_r4_bulk',
                component: ComponentCreator('/fhir_fli_documentation/docs/fhir_r4_bulk', 'dff'),
                exact: true,
                sidebar: "tutorialSidebar"
              },
              {
                path: '/fhir_fli_documentation/docs/fhir_r4_db',
                component: ComponentCreator('/fhir_fli_documentation/docs/fhir_r4_db', 'f61'),
                exact: true,
                sidebar: "tutorialSidebar"
              },
              {
                path: '/fhir_fli_documentation/docs/fhir_r4_path',
                component: ComponentCreator('/fhir_fli_documentation/docs/fhir_r4_path', 'f33'),
                exact: true,
                sidebar: "tutorialSidebar"
              },
              {
                path: '/fhir_fli_documentation/docs/fhir_r4_validation',
                component: ComponentCreator('/fhir_fli_documentation/docs/fhir_r4_validation', '2e6'),
                exact: true,
                sidebar: "tutorialSidebar"
              },
              {
                path: '/fhir_fli_documentation/docs/mapping/fhir_mapping',
                component: ComponentCreator('/fhir_fli_documentation/docs/mapping/fhir_mapping', '912'),
                exact: true,
                sidebar: "tutorialSidebar"
              },
              {
                path: '/fhir_fli_documentation/docs/mapping/fhir_mapping_engine',
                component: ComponentCreator('/fhir_fli_documentation/docs/mapping/fhir_mapping_engine', '48a'),
                exact: true,
                sidebar: "tutorialSidebar"
              },
              {
                path: '/fhir_fli_documentation/docs/mapping/fhirmap_parsing',
                component: ComponentCreator('/fhir_fli_documentation/docs/mapping/fhirmap_parsing', 'b75'),
                exact: true,
                sidebar: "tutorialSidebar"
              }
            ]
          }
        ]
      }
    ]
  },
  {
    path: '/fhir_fli_documentation/',
    component: ComponentCreator('/fhir_fli_documentation/', '176'),
    exact: true
  },
  {
    path: '*',
    component: ComponentCreator('*'),
  },
];
