import 'package:japanese_word_tokenizer/japanese_word_tokenizer.dart';

void main() {
  String text = '消えてくれないかなあ';
  List<dynamic> tokens = tokenize(text);
  print(tokens);
}
