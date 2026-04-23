import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/theme.dart';

/// Document-wide style additions on top of what jaspr_content's theme
/// already provides. Mounted from the layout so it renders on every page.
class SiteStyles extends StatelessComponent {
  const SiteStyles({super.key});

  @override
  Component build(BuildContext context) {
    return Document.head(children: [Style(styles: _styles)]);
  }

  static List<StyleRule> get _styles => [
    // Underline prose links so they're visibly distinct from surrounding text.
    // Scoped to .content-container so it doesn't touch sidebar/header/footer
    // or headings that wrap a link for anchoring.
    css('.content-container p a, .content-container li a, .content-container td a').styles(
      textDecoration: TextDecoration(line: TextDecorationLine.underline),
    ),
    css(
      '.content-container p a:hover, .content-container li a:hover, .content-container td a:hover',
    ).styles(opacity: 0.8),

    // Table polish: subtle borders, padding, emphasized header row.
    css('.content-container table').styles(
      width: 100.percent,
      margin: Margin.symmetric(vertical: 1.rem),
      border: Border(color: ContentColors.quoteBorders, width: 1.px, style: BorderStyle.solid),
      raw: {'border-collapse': 'collapse'},
    ),
    css('.content-container th, .content-container td').styles(
      padding: Padding.symmetric(horizontal: 0.75.rem, vertical: 0.5.rem),
      border: Border(color: ContentColors.quoteBorders, width: 1.px, style: BorderStyle.solid),
    ),
    css('.content-container th').styles(
      fontWeight: FontWeight.w700,
      textAlign: TextAlign.left,
      backgroundColor: ContentColors.preBg,
    ),

    // Sidebar: a faint divider line between collapsible groups so the
    // accordion structure reads as a list of discrete sections.
    css('.sidebar .sidebar-group.collapsible').styles(
      border: Border.only(
        bottom: BorderSide(color: ContentColors.quoteBorders, width: 1.px),
      ),
      padding: Padding.only(bottom: 0.5.rem),
    ),
    css('.sidebar .sidebar-group.collapsible:last-of-type').styles(
      raw: {'border-bottom': 'none'},
    ),
  ];
}
