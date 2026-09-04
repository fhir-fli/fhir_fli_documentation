import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_content/theme.dart';

/// Document-wide style additions on top of what jaspr_content's theme
/// already provides. Mounted from the layout so it renders on every page.
///
/// Sections, in order: content typography, inline code, tables, fenced code
/// blocks (chrome + highlight.js palette), the landing-page card grid, the
/// table of contents, and the header nav links.
class SiteStyles extends StatelessComponent {
  const SiteStyles({super.key});

  @override
  Component build(BuildContext context) {
    return Document.head(children: [Style(styles: _styles)]);
  }

  static List<StyleRule> get _styles => [
    // ---- Content typography -------------------------------------------
    css('.content-container .content-header h1').styles(
      fontSize: 2.5.rem,
      letterSpacing: (-0.02).em,
      lineHeight: 1.15.em,
    ),
    css('.content-container .content-header p').styles(
      color: ContentColors.lead,
      lineHeight: 1.5.em,
    ),
    css('.content h2').styles(
      padding: Padding.only(bottom: 0.3.em),
      border: Border.only(
        bottom: BorderSide(width: 1.px, color: ContentColors.hr),
      ),
    ),
    css('.content a').styles(
      raw: {
        'text-decoration-thickness': '1px',
        'text-underline-offset': '3px',
        'text-decoration-color': 'color-mix(in srgb, currentColor 35%, transparent)',
      },
    ),
    css('.content a:hover').styles(raw: {'text-decoration-color': 'currentColor'}),
    css('.content img').styles(radius: BorderRadius.circular(0.5.rem)),

    // ---- Inline code: a chip instead of the theme's literal backticks ---
    css('.content :not(pre) > code').styles(
      padding: Padding.symmetric(vertical: 0.1.em, horizontal: 0.3.em),
      radius: BorderRadius.circular(0.3.rem),
      fontSize: 0.85.em,
      fontWeight: FontWeight.w500,
      backgroundColor: Color('color-mix(in srgb, currentColor 9%, transparent)'),
    ),
    css('.content code::before, .content code::after').styles(raw: {'content': 'none'}),

    // ---- Tables ---------------------------------------------------------
    css('.content-container table').styles(
      display: Display.block,
      width: Unit.fitContent,
      maxWidth: 100.percent,
      margin: Margin.symmetric(vertical: 1.5.rem),
      border: Border.all(color: ContentColors.tdBorders, width: 1.px, style: BorderStyle.solid),
      radius: BorderRadius.circular(0.5.rem),
      overflow: Overflow.only(x: Overflow.auto),
      raw: {'border-collapse': 'separate', 'border-spacing': '0'},
    ),
    css('.content-container th, .content-container td').styles(
      padding: Padding.symmetric(horizontal: 0.75.rem, vertical: 0.5.rem),
      border: Border.only(
        bottom: BorderSide(color: ContentColors.tdBorders, width: 1.px),
        right: BorderSide(color: ContentColors.tdBorders, width: 1.px),
      ),
      raw: {'vertical-align': 'top'},
    ),
    css('.content-container th:last-child, .content-container td:last-child').styles(
      raw: {'border-right': 'none'},
    ),
    css('.content-container tbody tr:last-child td').styles(raw: {'border-bottom': 'none'}),
    css('.content-container th').styles(
      color: ContentColors.headings,
      textAlign: TextAlign.left,
      fontSize: 0.8.rem,
      fontWeight: FontWeight.w700,
      textTransform: TextTransform.upperCase,
      letterSpacing: 0.04.em,
      whiteSpace: WhiteSpace.noWrap,
      backgroundColor: Color('color-mix(in srgb, var(--primary) 8%, transparent)'),
    ),
    css('.content-container tbody tr:nth-child(even)').styles(
      backgroundColor: Color('color-mix(in srgb, currentColor 2.5%, transparent)'),
    ),

    // ---- Fenced code blocks --------------------------------------------
    css('.code-block', [
      css('&').styles(
        margin: Margin.symmetric(vertical: 1.5.em),
        border: Border.all(width: 1.px, color: Color('#ffffff14')),
        radius: BorderRadius.circular(0.5.rem),
        overflow: Overflow.hidden,
        backgroundColor: ContentColors.preBg,
      ),
      css('.code-head').styles(
        display: Display.flex,
        height: 2.rem,
        padding: Padding.only(left: 1.rem, right: 0.4.rem),
        border: Border.only(
          bottom: BorderSide(width: 1.px, color: Color('#ffffff14')),
        ),
        justifyContent: JustifyContent.spaceBetween,
        alignItems: AlignItems.center,
        color: Colors.white,
        backgroundColor: Color('#ffffff08'),
      ),
      css('.code-lang').styles(
        opacity: 0.55,
        userSelect: UserSelect.none,
        fontFamily: ContentTheme.currentCodeFont,
        fontSize: 0.65.rem,
        fontWeight: FontWeight.w600,
        textTransform: TextTransform.upperCase,
        letterSpacing: 0.08.em,
      ),
      css('.code-copy').styles(
        display: Display.inlineFlex,
        width: 1.6.rem,
        height: 1.6.rem,
        padding: Padding.zero,
        border: Border.none,
        radius: BorderRadius.circular(0.375.rem),
        opacity: 0.6,
        cursor: Cursor.pointer,
        transition: Transition('all', duration: 150.ms, curve: Curve.easeInOut),
        justifyContent: JustifyContent.center,
        alignItems: AlignItems.center,
        color: Colors.white,
        backgroundColor: Colors.transparent,
      ),
      css('.code-copy:hover, .code-copy:focus-visible').styles(opacity: 1, backgroundColor: Color('#ffffff1f')),
      css('pre').styles(
        margin: Margin.zero,
        radius: BorderRadius.circular(Unit.zero),
        raw: {'tab-size': '2'},
      ),

      // highlight.js token palette. Code blocks keep a dark background in
      // both themes, so one palette (GitHub Dark) serves both.
      css('.hljs-comment, .hljs-quote').styles(color: Color('#8b949e'), fontStyle: FontStyle.italic),
      css('.hljs-keyword, .hljs-selector-tag, .hljs-subst, .hljs-doctag').styles(color: Color('#ff7b72')),
      css(
        '.hljs-number, .hljs-literal, .hljs-variable, .hljs-template-variable, .hljs-symbol, .hljs-bullet',
      ).styles(color: Color('#79c0ff')),
      css('.hljs-string, .hljs-regexp, .hljs-addition').styles(color: Color('#a5d6ff')),
      css('.hljs-title, .hljs-section, .hljs-selector-id, .hljs-function .hljs-title').styles(
        color: Color('#d2a8ff'),
        fontWeight: FontWeight.w600,
      ),
      css('.hljs-type, .hljs-class .hljs-title, .hljs-built_in, .hljs-builtin-name').styles(color: Color('#ffa657')),
      css('.hljs-tag, .hljs-name, .hljs-attribute, .hljs-selector-class').styles(color: Color('#7ee787')),
      css('.hljs-attr').styles(color: Color('#79c0ff')),
      css('.hljs-meta, .hljs-meta-keyword').styles(color: Color('#d2a8ff')),
      css('.hljs-meta-string').styles(color: Color('#a5d6ff')),
      css('.hljs-deletion').styles(color: Color('#ffa198')),
      css('.hljs-emphasis').styles(fontStyle: FontStyle.italic),
      css('.hljs-strong').styles(fontWeight: FontWeight.w700),
    ]),

    // ---- Landing page: card grid ---------------------------------------
    css('.card-grid', [
      css('&').styles(
        display: Display.grid,
        margin: Margin.only(top: 1.rem, bottom: 2.rem),
        gap: Gap.all(1.rem),
        raw: {'grid-template-columns': 'repeat(auto-fill, minmax(14rem, 1fr))'},
      ),
      css('.card', [
        css('&').styles(
          display: Display.flex,
          padding: Padding.all(1.1.rem),
          border: Border.all(width: 1.px, color: ContentColors.hr),
          radius: BorderRadius.circular(0.75.rem),
          transition: Transition('all', duration: 150.ms, curve: Curve.easeInOut),
          flexDirection: FlexDirection.column,
          gap: Gap.row(0.35.rem),
          color: ContentColors.text,
          textDecoration: TextDecoration.none,
          backgroundColor: Color('color-mix(in srgb, currentColor 3%, transparent)'),
        ),
        css('&:hover').styles(
          border: Border.all(width: 1.px, color: ContentColors.primary),
          transform: Transform.translate(y: (-2).px),
          backgroundColor: Color('color-mix(in srgb, var(--primary) 6%, transparent)'),
        ),
        css('h3').styles(
          display: Display.flex,
          margin: Margin.zero,
          alignItems: AlignItems.center,
          gap: Gap.column(0.5.rem),
          color: ContentColors.headings,
          fontSize: 1.rem,
          fontWeight: FontWeight.w700,
        ),
        css('h3 code').styles(
          padding: Padding.symmetric(vertical: 0.1.em, horizontal: 0.4.em),
          radius: BorderRadius.circular(0.3.rem),
          color: ContentColors.primary,
          fontFamily: ContentTheme.currentCodeFont,
          fontSize: 0.85.em,
          fontWeight: FontWeight.w600,
          backgroundColor: Color('color-mix(in srgb, var(--primary) 12%, transparent)'),
        ),
        css('p').styles(margin: Margin.zero, fontSize: 0.875.rem, lineHeight: 1.45.em),
        css('.tag').styles(
          display: Display.inlineBlock,
          padding: Padding.symmetric(vertical: 0.05.em, horizontal: 0.5.em),
          margin: Margin.only(left: Unit.auto),
          radius: BorderRadius.circular(1.rem),
          opacity: 0.7,
          fontSize: 0.65.rem,
          fontWeight: FontWeight.w600,
          textTransform: TextTransform.upperCase,
          letterSpacing: 0.05.em,
          backgroundColor: Color('color-mix(in srgb, currentColor 10%, transparent)'),
        ),
      ]),
    ]),
    css('.button-row', [
      css('&').styles(
        display: Display.flex,
        margin: Margin.only(top: 1.5.rem, bottom: 2.5.rem),
        flexWrap: FlexWrap.wrap,
        gap: Gap.all(0.75.rem),
      ),
      css('a').styles(
        display: Display.inlineFlex,
        padding: Padding.symmetric(vertical: 0.6.rem, horizontal: 1.1.rem),
        border: Border.all(width: 1.px, color: ContentColors.primary),
        radius: BorderRadius.circular(0.5.rem),
        transition: Transition('all', duration: 150.ms, curve: Curve.easeInOut),
        alignItems: AlignItems.center,
        gap: Gap.column(0.5.rem),
        color: ContentColors.primary,
        fontSize: 0.95.rem,
        fontWeight: FontWeight.w600,
        textDecoration: TextDecoration.none,
      ),
      css('a.primary').styles(color: Colors.white, backgroundColor: ContentColors.primary),
      css('a:hover').styles(opacity: 0.9, transform: Transform.translate(y: (-1).px)),
    ]),

    // ---- Table of contents ---------------------------------------------
    css('aside.toc a').styles(
      opacity: 0.7,
      transition: Transition('opacity', duration: 150.ms, curve: Curve.easeInOut),
      textDecoration: TextDecoration.none,
    ),
    css('aside.toc a:hover').styles(opacity: 1),

    // ---- Header nav links (the `.nav-link` items passed to SiteHeader) --
    css('.header .nav-link').styles(
      padding: Padding.symmetric(horizontal: 0.75.rem, vertical: 0.5.rem),
      radius: BorderRadius.circular(0.5.rem),
      transition: Transition('background-color', duration: 150.ms, curve: Curve.easeInOut),
      fontSize: 0.95.rem,
      fontWeight: FontWeight.w500,
      textDecoration: TextDecoration.none,
    ),
    css('.header .nav-link:hover').styles(
      backgroundColor: Color('color-mix(in srgb, currentColor 6%, transparent)'),
    ),
  ];
}
