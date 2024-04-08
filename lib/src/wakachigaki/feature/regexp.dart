final Map<String, RegExp> regexp = {
  'Kanji': RegExp(
      r'[\u3400-\u4DBF\u4E00-\u9FFF\uF900-\uFAFF]|[\uD840-\uD87F][\uDC00-\uDFFF]'),
  'NumeralKanji': RegExp(r'[一二三四五六七八九十百千万億兆]'),
  'Hiragana': RegExp(r'[ぁ-ん]'),
  'Katakana': RegExp(r'[ァ-ヴーｧ-ﾝﾞﾟ]'),
  'Alphabet': RegExp(r'[a-zA-Zａ-ｚＡ-Ｚ]'),
  'Numeral': RegExp(r'[0-9０-９]'),
};

bool isKanji(String text) {
  return regexp['Kanji']!.hasMatch(text);
}

bool isNumeralKanji(String text) {
  return regexp['NumeralKanji']!.hasMatch(text);
}

bool isHiragana(String text) {
  return regexp['Hiragana']!.hasMatch(text);
}

bool isKatakana(String text) {
  return regexp['Katakana']!.hasMatch(text);
}

bool isAlphabet(String text) {
  return regexp['Alphabet']!.hasMatch(text);
}

bool isNumeral(String text) {
  return regexp['Numeral']!.hasMatch(text);
}
