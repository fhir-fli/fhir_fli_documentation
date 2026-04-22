/// The entrypoint for the **server** environment.
///
/// The [main] method will only be executed on the server during pre-rendering.
/// To run code on the client, check the `main.client.dart` file.
library;

import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';
import 'package:jaspr_content/components/callout.dart';
import 'package:jaspr_content/components/github_button.dart';
import 'package:jaspr_content/components/header.dart';
import 'package:jaspr_content/components/image.dart';
import 'package:jaspr_content/components/sidebar.dart';
import 'package:jaspr_content/components/theme_toggle.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:jaspr_content/theme.dart';

import 'components/footer.dart';

// This file is generated automatically by Jaspr, do not remove or edit.
import 'main.server.options.dart';

void main() {
  Jaspr.initializeApp(options: defaultServerOptions);
  runApp(
    ContentApp(
      templateEngine: MustacheTemplateEngine(),
      parsers: [MarkdownParser()],
      extensions: [
        HeadingAnchorsExtension(),
        TableOfContentsExtension(),
      ],
      components: [
        Callout(),
        Image(zoom: true),
      ],
      layouts: [
        DocsLayout(
          header: Header(
            title: 'FHIR-FLI',
            logo: 'images/fhir-fli-logo.svg',
            items: [
              a(classes: 'nav-link', href: 'docs/', [Component.text('Getting Started')]),
              a(classes: 'nav-link', href: 'about', [Component.text('About')]),
              a(classes: 'nav-link', href: 'contact', [Component.text('Contact')]),
              ThemeToggle(),
              GitHubButton(repo: 'fhir-fli/fhir_fli_documentation'),
            ],
          ),
          sidebar: Sidebar(
            groups: [
              SidebarGroup(
                links: [
                  SidebarLink(text: 'Getting Started', href: 'docs/'),
                  SidebarLink(text: 'About', href: '/about'),
                  SidebarLink(text: 'Contact', href: '/contact'),
                ],
              ),
              SidebarGroup(
                title: 'FHIR R4b Core',
                links: [
                  SidebarLink(text: 'fhir_r4', href: 'docs/core/fhir_r4'),
                  SidebarLink(text: 'Basic Object', href: 'docs/core/basic_object'),
                  SidebarLink(text: 'Serialization', href: 'docs/core/serialization'),
                  SidebarLink(text: 'Class Structure', href: 'docs/core/class_structure'),
                  SidebarLink(text: 'Polymorphic Types', href: 'docs/core/polymorphic_types'),
                  SidebarLink(text: 'Primitive Types', href: 'docs/core/primitive_types'),
                  SidebarLink(text: 'Enums', href: 'docs/core/enums'),
                  SidebarLink(text: 'Migration', href: 'docs/core/migration'),
                ],
              ),
              SidebarGroup(
                title: 'REST Client',
                links: [
                  SidebarLink(text: 'fhir_r4_at_rest', href: 'docs/at_rest/fhir_r4_at_rest'),
                  SidebarLink(text: 'Requests', href: 'docs/at_rest/restful_requests'),
                  SidebarLink(text: 'Parameters', href: 'docs/at_rest/restful_parameters'),
                ],
              ),
              SidebarGroup(
                title: 'Auth',
                links: [
                  SidebarLink(text: 'fhir_r4_auth', href: 'docs/auth/fhir_r4_auth'),
                  SidebarLink(text: 'Installation', href: 'docs/auth/installation'),
                  SidebarLink(text: 'Standalone Launch', href: 'docs/auth/standalone-launch'),
                ],
              ),
              SidebarGroup(
                title: 'Mapping',
                links: [
                  SidebarLink(text: 'FHIR Mapping', href: 'docs/mapping/fhir_mapping'),
                  SidebarLink(text: 'FHIRMap Parsing', href: 'docs/mapping/fhirmap_parsing'),
                  SidebarLink(text: 'Mapping Engine', href: 'docs/mapping/fhir_mapping_engine'),
                ],
              ),
              SidebarGroup(
                title: 'Additional Packages',
                links: [
                  SidebarLink(text: 'fhir_r4_db', href: 'docs/fhir_r4_db'),
                  SidebarLink(text: 'fhir_r4_bulk', href: 'docs/fhir_r4_bulk'),
                  SidebarLink(text: 'fhir_r4_path', href: 'docs/fhir_r4_path'),
                  SidebarLink(text: 'fhir_r4_validation', href: 'docs/fhir_r4_validation'),
                  SidebarLink(text: 'fhir_r4_cql', href: 'docs/fhir_r4_cql'),
                  SidebarLink(text: 'UCUM', href: 'docs/ucum'),
                ],
              ),
              SidebarGroup(
                title: 'Demos',
                links: [
                  SidebarLink(text: 'FHIRPath Demo', href: 'docs/demos/fhir_path_demo'),
                ],
              ),
              SidebarGroup(
                title: 'Botswana AMR IG',
                links: [
                  SidebarLink(text: 'Overview', href: 'docs/bw_amr_ig/bw_amr_ig_overview'),
                  SidebarLink(text: 'Architecture', href: 'docs/bw_amr_ig/bw_amr_ig_architecture'),
                  SidebarLink(text: 'WHONET Export', href: 'docs/bw_amr_ig/bw_amr_ig_whonet'),
                  SidebarLink(text: 'Flutter App', href: 'docs/bw_amr_ig/bw_amr_ig_flutter'),
                  SidebarLink(text: 'Published IG', href: 'docs/bw_amr_ig_ig'),
                ],
              ),
              SidebarGroup(
                title: 'Cicada',
                links: [
                  SidebarLink(text: 'Overview', href: 'docs/cicada/cicada_overview'),
                  SidebarLink(text: 'Demo', href: 'docs/cicada/cicada_demo'),
                  SidebarLink(text: 'Architecture', href: 'docs/cicada/cicada_architecture'),
                  SidebarLink(text: 'Usage', href: 'docs/cicada/cicada_usage'),
                  SidebarLink(text: 'WHO Support', href: 'docs/cicada/cicada_who'),
                  SidebarLink(text: 'Published IG', href: 'docs/cicada_ig'),
                ],
              ),
              SidebarGroup(
                title: 'Drosophila',
                links: [
                  SidebarLink(text: 'Overview', href: 'docs/drosophila/drosophila_overview'),
                  SidebarLink(text: 'Demo', href: 'docs/drosophila/drosophila_demo'),
                ],
              ),
              SidebarGroup(
                title: 'FHIR ANT',
                links: [
                  SidebarLink(text: 'Overview', href: 'docs/fhirant/fhirant_overview'),
                  SidebarLink(text: 'Getting Started', href: 'docs/fhirant/fhirant_getting_started'),
                  SidebarLink(text: 'Capabilities', href: 'docs/fhirant/fhirant_capabilities'),
                  SidebarLink(text: 'Security', href: 'docs/fhirant/fhirant_security'),
                  SidebarLink(text: 'API Reference', href: 'docs/fhirant/fhirant_api_reference'),
                  SidebarLink(text: 'CLI', href: 'docs/fhirant/fhirant_cli'),
                  SidebarLink(text: 'Privacy Policy', href: 'docs/fhirant/fhirant_privacy_policy'),
                ],
              ),
            ],
          ),
          footer: const SiteFooter(),
        ),
      ],
      theme: ContentTheme(
        primary: ThemeColor(ThemeColors.blue.$500, dark: ThemeColors.blue.$300),
        background: ThemeColor(ThemeColors.slate.$50, dark: ThemeColors.zinc.$950),
        colors: [
          ContentColors.quoteBorders.apply(ThemeColors.blue.$400),
        ],
      ),
    ),
  );
}
