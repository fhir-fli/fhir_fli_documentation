import 'package:highlight/highlight.dart' show highlight;
import 'package:highlight/languages/bash.dart' as lang_bash;
import 'package:highlight/languages/dart.dart' as lang_dart;
import 'package:highlight/languages/http.dart' as lang_http;
import 'package:highlight/languages/json.dart' as lang_json;
import 'package:highlight/languages/kotlin.dart' as lang_kotlin;
import 'package:highlight/languages/xml.dart' as lang_xml;
import 'package:highlight/languages/yaml.dart' as lang_yaml;
import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';
import 'package:jaspr_content/jaspr_content.dart';

import 'code_copy_button.dart';

/// Renders fenced code blocks with server-side syntax highlighting.
///
/// jaspr_content's own `CodeBlock` uses `syntax_highlight_lite`, which ships
/// a Dart grammar only and throws on every other fence language, so it was
/// never usable here (the docs use bash, yaml, json, xml, kotlin, ...).
/// This component runs `package:highlight` (a Dart port of highlight.js) at
/// build time and emits standard `hljs-*` spans; the palette lives in
/// `SiteStyles`. Languages with no grammar (fhirpath, regex) render as plain
/// text rather than failing the build.
class HighlightedCodeBlock extends CustomComponent {
  HighlightedCodeBlock() : super.base();

  /// Fence names that map onto a registered grammar.
  static const Map<String, String> _aliases = {
    'dart': 'dart',
    'bash': 'bash',
    'sh': 'bash',
    'shell': 'bash',
    'zsh': 'bash',
    'console': 'bash',
    'yaml': 'yaml',
    'yml': 'yaml',
    'json': 'json',
    'xml': 'xml',
    'html': 'xml',
    'kotlin': 'kotlin',
    'kt': 'kotlin',
    'http': 'http',
  };

  static bool _registered = false;

  static void _register() {
    if (_registered) return;
    highlight.registerLanguages({
      'dart': lang_dart.dart,
      'bash': lang_bash.bash,
      'yaml': lang_yaml.yaml,
      'json': lang_json.json,
      'xml': lang_xml.xml,
      'kotlin': lang_kotlin.kotlin,
      'http': lang_http.http,
    });
    _registered = true;
  }

  @override
  Component? create(Node node, NodesBuilder builder) {
    if (node case ElementNode(tag: 'pre', children: [ElementNode(tag: 'code', :final children, :final attributes)])) {
      var language = attributes['language'];
      final cls = attributes['class'];
      if (language == null && cls != null && cls.startsWith('language-')) {
        language = cls.substring('language-'.length);
      }

      var source = children?.map((c) => c.innerText).join() ?? '';
      if (source.endsWith('\n')) source = source.substring(0, source.length - 1);

      final grammar = language == null ? null : _aliases[language.toLowerCase()];
      Component body;
      if (grammar != null) {
        _register();
        body = RawText(highlight.parse(source, language: grammar).toHtml());
      } else {
        body = Component.text(source);
      }

      // A header strip above the code holds the language label and the copy
      // button, so neither ever sits on top of a long first line.
      return div(classes: 'code-block', [
        div(classes: 'code-head', [
          span(classes: 'code-lang', [Component.text(language ?? '')]),
          const CodeCopyButton(),
        ]),
        pre([
          code(classes: 'hljs', [body]),
        ]),
      ]);
    }
    return null;
  }
}
