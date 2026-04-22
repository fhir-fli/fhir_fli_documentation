import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/components/sidebar.dart';
import 'package:jaspr_content/jaspr_content.dart';

/// Drop-in replacement for [Sidebar] whose titled groups render as
/// native `<details>/<summary>` elements so the user can collapse and
/// expand them. Untitled groups remain always-visible.
///
/// The group containing the current page auto-opens on load.
class CollapsibleSidebar extends StatelessComponent {
  const CollapsibleSidebar({required this.groups, this.currentRoute, super.key});

  final List<SidebarGroup> groups;
  final String? currentRoute;

  @override
  Component build(BuildContext context) {
    final current = _normalize(currentRoute ?? context.page.url);

    return Component.fragment([
      Document.head(children: [Style(styles: _styles)]),
      nav(classes: 'sidebar', [
        button(classes: 'sidebar-close', [Component.text('×')]),
        div([
          for (final group in groups) _buildGroup(group, current),
        ]),
      ]),
    ]);
  }

  /// Returns the href without a leading `/` so links with and without leading
  /// slashes can be compared regardless of which form the config uses.
  static String _normalize(String href) => href.startsWith('/') ? href.substring(1) : href;

  Component _buildGroup(SidebarGroup group, String currentRoute) {
    final linksList = ul([
      for (final link in group.links)
        li([
          div(classes: _normalize(link.href) == currentRoute ? 'active' : null, [
            a(href: link.href, [Component.text(link.text)]),
          ]),
        ]),
    ]);

    if (group.title == null) {
      return div(classes: 'sidebar-group', [linksList]);
    }

    final containsCurrent = group.links.any((l) => _normalize(l.href) == currentRoute);

    return details(
      classes: 'sidebar-group collapsible',
      open: containsCurrent,
      [
        summary([Component.text(group.title!)]),
        linksList,
      ],
    );
  }

  static List<StyleRule> get _styles => [
    css('.sidebar .sidebar-group.collapsible').styles(
      margin: Margin.only(bottom: 0.5.rem),
    ),
    css('.sidebar .sidebar-group.collapsible > summary').styles(
      cursor: Cursor.pointer,
      fontWeight: FontWeight.w700,
      padding: Padding.symmetric(vertical: 0.35.rem),
      listStyle: ListStyle.none,
      userSelect: UserSelect.none,
    ),
    css('.sidebar .sidebar-group.collapsible > summary::-webkit-details-marker').styles(
      display: Display.none,
    ),
    css('.sidebar .sidebar-group.collapsible > summary::before').styles(
      raw: {'content': '"▸"'},
      display: Display.inlineBlock,
      fontSize: 0.75.em,
      margin: Margin.only(right: 0.4.rem),
      transition: Transition('transform', duration: 120.ms),
    ),
    css('.sidebar .sidebar-group.collapsible[open] > summary::before').styles(
      transform: Transform.rotate(90.deg),
    ),
  ];
}
