import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/theme.dart';

import 'site_styles.dart';

class SiteFooter extends StatelessComponent {
  const SiteFooter({super.key});

  @override
  Component build(BuildContext context) {
    return Component.fragment([
      const SiteStyles(),
      Document.head(children: [Style(styles: _styles)]),
      footer(classes: 'site-footer', [
        div(classes: 'footer-columns', [
          _column('Packages', const [
            ('fhir_r4', 'https://pub.dev/packages/fhir_r4'),
            ('fhir_r5', 'https://pub.dev/packages/fhir_r5'),
            ('fhir_r6', 'https://pub.dev/packages/fhir_r6'),
            ('fhir_path', 'https://pub.dev/packages/fhir_path'),
            ('cql', 'https://pub.dev/packages/cql'),
            ('All packages on pub.dev', 'https://pub.dev/publishers/fhirfli.dev/packages'),
          ]),
          _column('Documentation', const [
            ('Getting Started', 'docs/'),
            ('Core package', 'docs/core/fhir_r4'),
            ('REST client', 'docs/at_rest/fhir_r4_at_rest'),
            ('SMART on FHIR auth', 'docs/auth/fhir_r4_auth'),
            ('Local database', 'docs/fhir_r4_db'),
            ('FHIRPath demo', 'docs/demos/fhir_path_demo'),
          ]),
          _column('Project', const [
            ('About', 'about'),
            ('Contact', 'contact'),
            ('GitHub', 'https://github.com/fhir-fli'),
            ('This site\'s source', 'https://github.com/fhir-fli/fhir_fli_documentation'),
          ]),
        ]),
        p(classes: 'footer-note', [
          Component.text('FHIR® is the registered trademark of HL7 and is used with the permission of HL7. '),
          Component.text('Built with '),
          a(href: 'https://jaspr.site', [Component.text('Jaspr')]),
          Component.text('.'),
        ]),
      ]),
    ]);
  }

  static Component _column(String title, List<(String, String)> links) {
    return div(classes: 'footer-column', [
      h4([Component.text(title)]),
      ul([
        for (final (label, href) in links)
          li([
            a(href: href, [Component.text(label)]),
          ]),
      ]),
    ]);
  }

  static List<StyleRule> get _styles => [
    css('.site-footer', [
      css('&').styles(
        padding: Padding.only(top: 2.5.rem, bottom: 1.rem),
        margin: Margin.only(top: 4.rem),
        border: Border.only(
          top: BorderSide(color: ContentColors.hr, width: 1.px),
        ),
        fontSize: 0.875.rem,
      ),
      css('.footer-columns').styles(
        display: Display.flex,
        flexWrap: FlexWrap.wrap,
        gap: Gap(row: 2.rem, column: 4.rem),
      ),
      css('.footer-column').styles(minWidth: 10.rem),
      css('.footer-column h4').styles(
        margin: Margin.only(bottom: 0.75.rem),
        color: ContentColors.headings,
        fontSize: 0.75.rem,
        fontWeight: FontWeight.w700,
        textTransform: TextTransform.upperCase,
        letterSpacing: 0.05.em,
      ),
      css('.footer-column ul').styles(padding: Padding.zero, margin: Margin.zero, listStyle: ListStyle.none),
      css('.footer-column li').styles(margin: Margin.only(bottom: 0.4.rem)),
      css('.footer-column a').styles(
        opacity: 0.75,
        transition: Transition('opacity', duration: 150.ms, curve: Curve.easeInOut),
        textDecoration: TextDecoration.none,
      ),
      css('.footer-column a:hover').styles(opacity: 1),
      css('.footer-note').styles(
        margin: Margin.only(top: 2.5.rem),
        opacity: 0.6,
        fontSize: 0.8.rem,
        lineHeight: 1.6.em,
      ),
      css('.footer-note a').styles(color: Color.inherit),
    ]),
  ];
}
