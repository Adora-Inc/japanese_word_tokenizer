import 'package:japanese_word_tokenizer/src/wakachigaki/feature/feature.dart';
import 'package:japanese_word_tokenizer/src/wakachigaki/model/model.dart';
import 'package:japanese_word_tokenizer/src/wakachigaki/predict/predict.dart';

typedef TokenizerFn = List<String> Function(String text);

int nBuckets = model['config']['n_buckets'] as int;
int size = model['config']['size'] as int;
int offset = model['config']['offset'] as int;

TokenizerFn tokenizer(int nBuckets, int size, int offset) {
  final FeaturerFn f = featurer(nBuckets, size, offset);

  List<String> fn(String text) {
    final List<NgramFeature> chars = f(text);
    final List<bool> preds = predict(chars);

    List<String> reducer(List<String> acc, MapEntry<int, bool> item) {
      final int i = item.key;
      final bool willBreak = item.value;
      acc[acc.length - 1] += chars[i].char;
      if (willBreak) {
        acc.add('');
      }
      return acc;
    }

    final List<String> x = preds.asMap().entries.fold(<String>[''], reducer);
    return x.where((element) => element.isNotEmpty).toList();
  }

  return fn;
}

final TokenizerFn tokenize = tokenizer(nBuckets, size, offset);
final TokenizerFn segment = tokenize;
