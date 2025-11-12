const docusaurus = require('@docusaurus/eslint-plugin');

module.exports = [
  {
    plugins: {
      '@docusaurus': docusaurus,
    },
    rules: {
      ...docusaurus.configs.recommended.rules,
    },
  },
];
