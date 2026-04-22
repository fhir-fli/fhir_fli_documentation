import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class SiteFooter extends StatelessComponent {
  const SiteFooter({super.key});

  @override
  Component build(BuildContext context) {
    return Component.fragment([
      Document.head(children: [Style(styles: _styles)]),
      footer(classes: 'site-footer', [
        div(classes: 'footer-columns', [
          _column('Docs', const [
            ('Getting Started', 'docs/'),
          ]),
          _column('Standalone Pages', const [
            ('About', 'about'),
            ('Contact', 'contact'),
          ]),
          _column('More', const [
            ('GitHub', 'https://github.com/fhir-fli/fhir_fli_documentation'),
          ]),
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
    css('.site-footer').styles(
      padding: Padding.symmetric(horizontal: 2.rem, vertical: 3.rem),
      border: Border.only(
        top: BorderSide(color: Color('#0000000d'), width: 1.px),
      ),
      fontSize: 0.9.rem,
    ),
    css('.site-footer .footer-columns').styles(
      display: Display.flex,
      flexWrap: FlexWrap.wrap,
      gap: Gap.column(3.rem),
      margin: Margin.symmetric(horizontal: Unit.auto),
      maxWidth: 60.rem,
    ),
    css('.site-footer .footer-column').styles(minWidth: 10.rem),
    css('.site-footer .footer-column h4').styles(
      fontWeight: FontWeight.w700,
      margin: Margin.only(bottom: 0.5.rem),
    ),
    css('.site-footer .footer-column ul').styles(
      listStyle: ListStyle.none,
      padding: Padding.zero,
      margin: Margin.zero,
    ),
    css('.site-footer .footer-column li').styles(margin: Margin.only(bottom: 0.25.rem)),
    css('.site-footer .footer-column a').styles(textDecoration: TextDecoration.none),
    css('.header .nav-link').styles(
      padding: Padding.symmetric(horizontal: 0.75.rem, vertical: 0.5.rem),
      textDecoration: TextDecoration.none,
      fontSize: 0.95.rem,
    ),
    css('.header .nav-link:hover').styles(
      textDecoration: TextDecoration(line: TextDecorationLine.underline),
    ),
  ];
}
