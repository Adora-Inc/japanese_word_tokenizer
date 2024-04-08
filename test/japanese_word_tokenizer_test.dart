import 'package:japanese_word_tokenizer/japanese_word_tokenizer.dart';

void main() {
  String text = 'お菓子しね';
  List<dynamic> tokens = tokenize(text);
  print(tokens);
}
