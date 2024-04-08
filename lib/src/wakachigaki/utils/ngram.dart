typedef NgramFn = String Function(int size, int offset);

NgramFn Function(int) ngram(List<String> chars) {
  NgramFn index(int i) {
    String get(int size, int offset) {
      if (size == 1) {
        return chars[i + offset];
      } else {
        return get(size - 1, offset) + get(1, offset + (size - 1));
      }
    }

    return get;
  }

  return index;
}
