// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

const lightCodeTheme = require('prism-react-renderer/themes/vsLight');
const darkCodeTheme = require('prism-react-renderer/themes/vsDark');

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: 'FHIR-FLI',
  tagline: 'FHIR with Flutter',
  url: 'https://fhir-fli.github.io',
  baseUrl: '/fhir_fli_documentation/',
  trailingSlash: false,
  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'warn',
  favicon: 'img/fhir-fli-logo.png',

  // GitHub pages deployment config.
  organizationName: 'fhir-fli', // GitHub org/user name
  projectName: 'fhir_fli_documentation', // Repo name

  i18n: {
    defaultLocale: 'en',
    locales: ['en'],
  },

  presets: [
    [
      'classic',
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          sidebarPath: require.resolve('./sidebars.js'),
          editUrl: 'https://github.com/fhir-fli/fhir_fli_documentation/tree/main/',
          routeBasePath: 'docs',
        },
        theme: {
          customCss: require.resolve('./src/css/custom.css'),
        },
      }),
    ],
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      navbar: {
        title: 'FHIR-FLI',
        logo: {
          alt: 'FHIR-FLI Logo',
          src: 'img/fhir-fli-logo.svg',
        },
        items: [
          { type: 'doc', docId: 'getting-started', position: 'left', label: 'Getting Started' },
          { to: '/about', label: 'About', position: 'left' },
          { to: '/contact', label: 'Contact', position: 'left' },
          {
            href: 'https://mayjuun.com/',
            position: 'right',
            className: 'navbar-mayjuun-icon',
          },
          {
            href: 'https://www.research.chop.edu/global-health-informatics',
            position: 'right',
            className: 'navbar-chop-icon',
          },
          {
            href: 'https://github.com/fhir-fli/fhir_fli_documentation',
            position: 'right',
            className: 'navbar-github-icon',
            'aria-label': 'GitHub repository',
          },
        ],
      },
      footer: {
        links: [
          {
            title: 'Docs',
            items: [
              { label: 'Getting Started', to: '/docs' },
            ],
          },
          {
            title: 'Standalone Pages',
            items: [
              { label: 'About', to: '/about' },
              { label: 'Contact', to: '/contact' },
              { label: 'MayJuun', href: 'https://mayjuun.com/about/' },
            ],
          },
          {
            title: 'More',
            items: [
              {
                label: 'GitHub',
                href: 'https://github.com/fhir-fli/fhir_fli_documentation',
              },
            ],
          },
        ],
      },
      prism: {
        additionalLanguages: ['bash', 'dart', 'yaml'],
        theme: lightCodeTheme,
        darkTheme: darkCodeTheme,
      },
    }),
};

module.exports = config;
