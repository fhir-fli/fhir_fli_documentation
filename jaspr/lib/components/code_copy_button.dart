import 'dart:async';

import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' as web;

/// Copies the text of the sibling `<pre><code>` to the clipboard.
///
/// Kept in its own file so the client bundle that hydrates it does not pull
/// in the server-side highlighter used by `HighlightedCodeBlock`.
@client
class CodeCopyButton extends StatefulComponent {
  const CodeCopyButton({super.key});

  @override
  State<CodeCopyButton> createState() => _CodeCopyButtonState();
}

class _CodeCopyButtonState extends State<CodeCopyButton> {
  bool copied = false;

  @override
  Component build(BuildContext context) {
    return button(
      classes: 'code-copy',
      attributes: {'aria-label': copied ? 'Copied' : 'Copy code', 'title': 'Copy'},
      events: {
        'click': (event) {
          final target = event.currentTarget as web.Element;
          final content = target.parentElement?.querySelector('pre code')?.textContent;
          if (content == null) return;
          web.window.navigator.clipboard.writeText(content);
          setState(() => copied = true);
          Timer(const Duration(seconds: 2), () => setState(() => copied = false));
        },
      },
      [copied ? const _CheckIcon() : const _CopyIcon()],
    );
  }
}

class _CopyIcon extends StatelessComponent {
  const _CopyIcon();

  @override
  Component build(BuildContext context) {
    return svg(
      viewBox: '0 0 24 24',
      attributes: {'width': '16', 'height': '16', 'fill': 'none', 'stroke': 'currentColor', 'stroke-width': '2'},
      [
        rect(attributes: {'x': '9', 'y': '9', 'width': '13', 'height': '13', 'rx': '2'}, []),
        path(d: 'M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1', []),
      ],
    );
  }
}

class _CheckIcon extends StatelessComponent {
  const _CheckIcon();

  @override
  Component build(BuildContext context) {
    return svg(
      viewBox: '0 0 24 24',
      attributes: {'width': '16', 'height': '16', 'fill': 'none', 'stroke': 'currentColor', 'stroke-width': '2.5'},
      [path(d: 'M20 6 9 17l-5-5', [])],
    );
  }
}
