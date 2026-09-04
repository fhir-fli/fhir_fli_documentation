import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/components/sidebar.dart';
import 'package:jaspr_content/jaspr_content.dart';
import 'package:jaspr_content/theme.dart';

/// Drop-in replacement for [Sidebar] whose titled groups render as
/// native `<details>/<summary>` elements so the user can collapse and
/// expand them. Untitled groups remain always-visible.
///
/// The group containing the current page auto-opens on load.
///
/// jaspr_content's [Sidebar] emits its own layout CSS from inside `build()`
/// (there is no global stylesheet for it), so replacing it means the
/// upstream `.sidebar` rules never reach the page. This component therefore
/// carries the complete set of sidebar styles itself: the upstream rules,
/// adapted to `<details>/<summary>` groups, plus the site's own additions.
class CollapsibleSidebar extends StatelessComponent {
  const CollapsibleSidebar({
    required this.groups,
    this.mobileNav = const [],
    this.currentRoute,
    super.key,
  });

  final List<SidebarGroup> groups;

  /// Links that live in the site header on wide screens but do not fit
  /// there on narrow ones. Rendered as an always-open group at the top of
  /// the sidebar and hidden by CSS at widths where the header shows them.
  final List<SidebarLink> mobileNav;

  final String? currentRoute;

  @override
  Component build(BuildContext context) {
    final current = _normalize(currentRoute ?? context.page.url);

    return Component.fragment([
      Document.head(children: [Style(styles: _styles)]),
      nav(classes: 'sidebar', [
        button(classes: 'sidebar-close', attributes: {'aria-label': 'Close navigation'}, [Component.text('×')]),
        div([
          if (mobileNav.isNotEmpty) div(classes: 'sidebar-group sidebar-mobile-nav', [_linkList(mobileNav, current)]),
          for (final group in groups) _buildGroup(group, current),
        ]),
      ]),
    ]);
  }

  /// Returns the href without a leading `/` so links with and without leading
  /// slashes can be compared regardless of which form the config uses.
  static String _normalize(String href) => href.startsWith('/') ? href.substring(1) : href;

  static Component _linkList(List<SidebarLink> links, String currentRoute) {
    return ul([
      for (final link in links)
        li([
          div(classes: _normalize(link.href) == currentRoute ? 'active' : null, [
            a(href: link.href, [Component.text(link.text)]),
          ]),
        ]),
    ]);
  }

  Component _buildGroup(SidebarGroup group, String currentRoute) {
    final linksList = _linkList(group.links, currentRoute);

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
    css('.sidebar', [
      css('&').styles(
        position: Position.relative(),
        padding: Padding.only(left: 0.5.rem, bottom: 1.25.rem, top: 0.75.rem),
        fontSize: 0.875.rem,
        lineHeight: 1.25.rem,
      ),
      css.media(MediaQuery.all(minWidth: 1024.px), [
        css('&').styles(padding: Padding.only(top: Unit.zero)),
      ]),

      // The close button only exists for the slide-in sidebar on narrow
      // screens. On wide screens the sidebar is always visible.
      css('.sidebar-close', [
        css('&').styles(
          position: Position.absolute(top: 0.5.rem, right: 0.75.rem),
          width: 2.rem,
          height: 2.rem,
          border: Border.none,
          radius: BorderRadius.circular(0.375.rem),
          cursor: Cursor.pointer,
          color: Color.inherit,
          fontSize: 1.5.rem,
          lineHeight: 1.em,
          backgroundColor: Colors.transparent,
        ),
        css('&:hover').styles(backgroundColor: Color('#0000000d')),
        css.media(MediaQuery.all(minWidth: 1024.px), [
          css('&').styles(display: Display.none),
        ]),
      ]),

      // Header links only appear in the sidebar when the header is too
      // narrow to hold them.
      css('.sidebar-mobile-nav', [
        css('&').styles(
          padding: Padding.only(top: 3.rem, right: 0.75.rem),
          border: Border.only(
            bottom: BorderSide(width: 1.px, color: ContentColors.hr),
          ),
        ),
        css('ul').styles(padding: Padding.only(bottom: 0.75.rem)),
        css.media(MediaQuery.all(minWidth: 1024.px), [
          css('&').styles(display: Display.none),
        ]),
      ]),

      css('.sidebar-group', [
        css('&').styles(
          padding: Padding.only(top: 1.rem, right: 0.75.rem),
        ),
        css('&.collapsible').styles(padding: Padding.only(top: 0.5.rem)),
        css('&.collapsible:first-of-type').styles(padding: Padding.only(top: 1.rem)),

        // Group title: an uppercase label with a chevron that turns when open.
        css('&.collapsible > summary', [
          css('&').styles(
            display: Display.flex,
            padding: Padding.symmetric(vertical: 0.45.rem, horizontal: 0.75.rem),
            radius: BorderRadius.circular(0.375.rem),
            opacity: 0.85,
            cursor: Cursor.pointer,
            userSelect: UserSelect.none,
            transition: Transition('all', duration: 150.ms, curve: Curve.easeInOut),
            alignItems: AlignItems.center,
            gap: Gap.column(0.5.rem),
            listStyle: ListStyle.none,
            color: ContentColors.headings,
            fontSize: 0.75.rem,
            fontWeight: FontWeight.w700,
            textTransform: TextTransform.upperCase,
            letterSpacing: 0.05.em,
          ),
          css('&:hover').styles(opacity: 1, backgroundColor: Color('#0000000d')),
          css('&::-webkit-details-marker').styles(display: Display.none),
          css('&::before').styles(
            content: '',
            display: Display.inlineBlock,
            width: 0.4.em,
            height: 0.4.em,
            margin: Margin.only(left: 0.1.em, bottom: 0.15.em),
            border: Border.only(
              right: BorderSide(width: 1.5.px, color: Color.currentColor),
              bottom: BorderSide(width: 1.5.px, color: Color.currentColor),
            ),
            opacity: 0.7,
            transition: Transition('transform', duration: 150.ms, curve: Curve.easeInOut),
            transform: Transform.rotate((-45).deg),
          ),
        ]),
        css('&.collapsible[open] > summary::before').styles(transform: Transform.rotate(45.deg)),

        // Links: a thin rail on the left keeps them visually inside their group.
        css('ul').styles(
          padding: Padding.zero,
          margin: Margin.only(top: 0.125.rem, left: 1.rem),
          border: Border.only(
            left: BorderSide(width: 1.px, color: ContentColors.hr),
          ),
          listStyle: ListStyle.none,
        ),
        css('&:not(.collapsible) ul').styles(margin: Margin.zero, border: Border.none),
        css('li', [
          css('div', [
            css('&').styles(
              display: Display.flex,
              margin: Margin.only(bottom: 1.px),
              radius: BorderRadius.circular(0.375.rem),
              opacity: 0.75,
              overflow: Overflow.hidden,
              transition: Transition('all', duration: 150.ms, curve: Curve.easeInOut),
              textOverflow: TextOverflow.ellipsis,
              whiteSpace: WhiteSpace.noWrap,
            ),
            css('&:hover').styles(opacity: 1, backgroundColor: Color('#0000000d')),
            css('&.active').styles(
              opacity: 1,
              color: ContentColors.primary,
              fontWeight: FontWeight.w700,
              backgroundColor: Color('color-mix(in srgb, currentColor 15%, transparent)'),
            ),
          ]),
          css('a').styles(
            display: Display.inlineFlex,
            padding: Padding.only(left: 12.px, top: 0.45.rem, bottom: 0.45.rem),
            flex: Flex(grow: 1),
            textDecoration: TextDecoration.none,
          ),
        ]),
      ]),
    ]),
  ];
}
