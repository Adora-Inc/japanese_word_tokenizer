import 'package:japanese_word_tokenizer/src/wakachigaki/feature/feature.dart';
import 'package:japanese_word_tokenizer/src/wakachigaki/utils/sigmoid.dart';

class NgramFeatureWithDistance extends NgramFeature {
  final int distance;

  NgramFeatureWithDistance({
    required String char,
    required List<NgramFeatureItem> features,
    required this.distance,
  }) : super(char: char, features: features);
}

typedef ProbabilityFn = double Function(NgramFeatureWithDistance feature);

ProbabilityFn probability(Map<String, dynamic> weight, int scale) {
  final int bias = weight['bias'] as int;

  int f(int score, NgramFeatureItem item) {
    final Map<String, dynamic> kind = weight[item.kind] ?? <String, dynamic>{};
    final Map<String, dynamic> size =
        kind[item.size.toString()] ?? <String, dynamic>{};
    final Map<String, dynamic> offset =
        size[item.offset.toString()] ?? <String, dynamic>{};
    final int value = offset[item.value] ?? 0;
    return score + value;
  }

  double fn(NgramFeatureWithDistance feature) {
    final int features = feature.features.fold(0, f);
    final int distance = feature.distance * (weight['distance'] as int);
    return sigmoid((bias + features + distance) / scale);
  }

  return fn;
}
