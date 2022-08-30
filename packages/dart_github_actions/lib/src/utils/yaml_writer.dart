/// Provides a method to serialize an object to a map capabable of being written
/// to yaml.
mixin YAMLObject {
  /// Encodes this object to a map that can be written in yaml format.
  Map<String, dynamic> toYaml();
}

/// {@template yaml_writer}
/// A serializer for writing objects in yaml format.
/// {@endtemplate}
class YAMLWriter {
  /// {@macro yaml_writer}
  const YAMLWriter();

  String write(Object root) {
    final buffer = StringBuffer();
    _write(root, buffer);
    return buffer.toString();
  }

  void _write(Object node, StringBuffer sb, {String currentIndent = ''}) {
    if (node is String) {
      if (node.contains('\n')) {
        final nextIdent = '$currentIndent  ';

        final endsWithLineBreak = node.endsWith('\n');

        List<String> lines;
        if (endsWithLineBreak) {
          sb.write(' |\n');
          lines = node.substring(0, node.length - 1).split('\n');
        } else {
          sb.write(' |-\n');
          lines = node.split('\n');
        }

        for (final line in lines) {
          sb
            ..write(nextIdent)
            ..write(line)
            ..write('\n');
        }
      } else if (node.contains('*')) {
        sb.write(" '$node'\n");
      } else {
        sb.write(' $node\n');
      }
    } else if (node is num || node is bool) {
      sb.write(' $node\n');
    }
    if (node is Map) {
      _writeMap(node, sb, currentIndent: currentIndent);
    } else if (node is List) {
      _writeList(node, sb, currentIndent: currentIndent);
    } else if (node is YAMLObject) {
      _writeMap(node.toYaml(), sb, currentIndent: currentIndent);
    }
  }

  void _writeMap(
    Map<dynamic, dynamic> map,
    StringBuffer sb, {
    String currentIndent = '',
  }) {
    if (map.isEmpty) {
      sb.write(' {}');
      return;
    }
    if (sb.isNotEmpty) sb.write('\n');
    for (final entry in map.entries) {
      sb
        ..write(currentIndent)
        ..writeMapKey(entry.key as String)
        ..write(':');
      _write(entry.value as Object, sb, currentIndent: '$currentIndent  ');
    }
  }

  void _writeList(
    List<dynamic> list,
    StringBuffer sb, {
    String currentIndent = '',
  }) {
    if (sb.isNotEmpty) sb.write('\n');
    final nextIndent = '$currentIndent  ';
    for (final entry in list) {
      sb
        ..write(currentIndent)
        ..write('-');
      _write(entry as Object, sb, currentIndent: nextIndent);
    }
  }
}

extension StringBufferX on StringBuffer {
  void writeMapKey(String key) {
    if (key.contains(' ')) {
      write("'$key'");
    } else {
      write(key);
    }
  }
}
