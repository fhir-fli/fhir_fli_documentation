import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/components/sidebar_toggle_button.dart';

/// Drop-in replacement for `jaspr_content`'s [Header] that lets the title
/// link's `href` be configured. The upstream component hardcodes `href="/"`,
/// which under a `<base href="/fhir_fli_documentation/">` deployment sends
/// the user to `https://fhir-fli.github.io/` (GitHub Pages root) instead of
/// the docs root, since absolute paths bypass the base.
///
/// jaspr_content's `Header` injects its layout CSS (`.header`,
/// `.header-title`, `.header-content`, `.header-items`) from inside its own
/// `build()` via `Document.head` — there is no global header stylesheet.
/// Because this component replaces `Header`, the upstream `Header` is never
/// mounted and that CSS would never reach the page. So [SiteHeader] carries
/// an identical copy of those style rules itself, making it a fully
/// self-contained drop-in replacement whose styling cannot silently vanish.
class SiteHeader extends StatelessComponent {
  const SiteHeader({
    required this.logo,
    required this.title,
    this.titleHref = './',
    this.leading = const [SidebarToggleButton()],
    this.items = const [],
    super.key,
  });

  /// The src href for the site logo image.
  final String logo;

  /// The site name rendered next to the logo.
  final String title;

  /// The destination of the title-link click. Use a base-relative value
  /// like `./` (the default) so it resolves to whatever `<base href>` is
  /// in effect, not to the protocol-host root.
  final String titleHref;

  /// Components rendered before the logo (defaults to the sidebar toggle).
  final List<Component> leading;

  /// Components rendered to the right of the title (nav links, theme
  /// toggle, GitHub button, etc).
  final List<Component> items;

  @override
  Component build(BuildContext context) {
    return Component.fragment([
      Document.head(children: [Style(styles: _styles)]),
      header(classes: 'header', [
        ...leading,
        a(classes: 'header-title', href: titleHref, [
          img(src: logo, alt: 'Logo'),
          span([Component.text(title)]),
        ]),
        div(classes: 'header-content', [
          div(classes: 'header-items', items),
        ]),
      ]),
    ]);
  }

  /// Verbatim copy of jaspr_content `Header`'s own `_styles`. Kept identical
  /// so this component renders pixel-for-pixel like the upstream header.
  static List<StyleRule> get _styles => [
    css('.header', [
      css('&').styles(
        height: 4.rem,
        display: Display.flex,
        alignItems: AlignItems.center,
        gap: Gap.column(1.rem),
        padding: Padding.symmetric(horizontal: 1.rem, vertical: .25.rem),
        margin: Margin.symmetric(horizontal: Unit.auto),
        border: Border.only(
          bottom: BorderSide(color: Color('#0000000d'), width: 1.px),
        ),
      ),
      css.media(MediaQuery.all(minWidth: 768.px), [
        css('&').styles(padding: Padding.symmetric(horizontal: 2.5.rem)),
      ]),
      css('.header-title', [
        css('&').styles(
          display: Display.inlineFlex,
          flex: Flex(basis: 17.rem),
          alignItems: AlignItems.center,
          gap: Gap.column(.75.rem),
        ),
        css('img').styles(height: 1.5.rem, width: Unit.auto),
        css('span').styles(fontWeight: FontWeight.w700),
      ]),
      css('.header-content', [
        css('&').styles(
          display: Display.flex,
          flex: Flex(grow: 1),
          justifyContent: JustifyContent.end,
        ),
      ]),
      css('.header-items', [
        css('&').styles(
          display: Display.flex,
          gap: Gap.column(0.25.rem),
        ),
      ]),
    ]),
  ];
}
