import 'package:japanese_word_tokenizer/japanese_word_tokenizer.dart';

void main() {
  String text = 'ここでテキストを分かち書きします';
  List<dynamic> tokens = tokenize(text);
  print(tokens);
}
