import 'package:japanese_word_tokenizer/src/wakachigaki/feature/regexp.dart';

const List<Map<String, dynamic>> rules = [
  {'fn': isKanji, 'rep': 'C'},
  {'fn': isNumeralKanji, 'rep': 'S'},
  {'fn': isHiragana, 'rep': 'H'},
  {'fn': isKatakana, 'rep': 'K'},
  {'fn': isAlphabet, 'rep': 'A'},
  {'fn': isNumeral, 'rep': 'N'},
];

String getCharType(String char) {
  for (Map<String, dynamic> rule in rules) {
    if ((rule['fn'] as Function)(char)) {
      return rule['rep'] as String;
    }
  }
  return 'O';
}
