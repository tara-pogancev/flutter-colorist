String extractGetterBodyFromDeclaration(String source) {
  // Find first '=>' or '{'
  final arrowIndex = source.indexOf('=>');
  final braceIndex = source.indexOf('{');

  if (arrowIndex == -1 && braceIndex == -1) {
    throw FormatException('No "=>" or "{" found in the getter declaration.');
  }

  if (arrowIndex != -1 && (braceIndex == -1 || arrowIndex < braceIndex)) {
    // Arrow-body getter
    return _extractArrowBody(source);
  } else {
    // Block-body getter
    return _extractBlockBody(source);
  }
}

String _extractArrowBody(String source) {
  bool inString = false;
  String? stringChar;
  bool inComment = false;

  for (int i = 0; i < source.length; i++) {
    final c = source[i];
    final next = i + 1 < source.length ? source[i + 1] : '';

    if (inComment) {
      if (source.substring(i).startsWith('*/')) {
        inComment = false;
        i++;
      } else if (source.substring(i).startsWith('\n')) {
        inComment = false;
      }
      continue;
    }

    if (inString) {
      if (c == stringChar && source[i - 1] != '\\') {
        inString = false;
        stringChar = null;
      }
      continue;
    }

    if (c == '/' && next == '/') {
      inComment = true;
      continue;
    } else if (c == '/' && next == '*') {
      inComment = true;
      continue;
    } else if (c == '"' || c == "'") {
      inString = true;
      stringChar = c;
      continue;
    }

    if (c == ';') return source.substring(0, i + 1).trim();
  }

  throw FormatException('No closing semicolon found for arrow-body getter.');
}

String _extractBlockBody(String source) {
  int depth = 0;
  bool inString = false;
  String? stringChar;
  bool inComment = false;

  for (int i = 0; i < source.length; i++) {
    final c = source[i];
    final next = i + 1 < source.length ? source[i + 1] : '';

    if (inComment) {
      if (source.substring(i).startsWith('*/')) {
        inComment = false;
        i++;
      } else if (source.substring(i).startsWith('\n')) {
        inComment = false;
      }
      continue;
    }

    if (inString) {
      if (c == stringChar && source[i - 1] != '\\') {
        inString = false;
        stringChar = null;
      }
      continue;
    }

    if (c == '/' && next == '/') {
      inComment = true;
      continue;
    } else if (c == '/' && next == '*') {
      inComment = true;
      continue;
    } else if (c == '"' || c == "'") {
      inString = true;
      stringChar = c;
      continue;
    }

    if (c == '{') depth++;
    if (c == '}') {
      depth--;
      if (depth == 0) return source.substring(0, i + 1).trim();
    }
  }

  throw FormatException(
      'No matching closing brace found for block-body getter.');
}
