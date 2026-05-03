import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/components/sidebar_toggle_button.dart';

/// Drop-in replacement for `jaspr_content`'s [Header] that lets the title
/// link's `href` be configured. The upstream component hardcodes `href="/"`,
/// which under a `<base href="/fhir_fli_documentation/">` deployment sends
/// the user to `https://fhir-fli.github.io/` (GitHub Pages root) instead of
/// the docs root, since absolute paths bypass the base.
///
/// All other markup, CSS classes, and styles match the upstream Header so
/// the existing `.header` rules in jaspr_content's stylesheet still apply.
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
}
