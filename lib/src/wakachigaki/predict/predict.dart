import 'package:japanese_word_tokenizer/src/wakachigaki/feature/feature.dart';
import 'package:japanese_word_tokenizer/src/wakachigaki/model/model.dart';
import 'package:japanese_word_tokenizer/src/wakachigaki/predict/proba.dart';

typedef ProbaPredictorFn = List<double>
    Function(Iterable<NgramFeature> features, [double threshold]);
typedef PredictorFn = List<bool> Function(Iterable<NgramFeature> features,
    [double threshold]);

ProbaPredictorFn probaPredictor(Map<String, dynamic> weight, int scale) {
  final Function probab = probability(weight, scale);

  List<double> fn(Iterable<NgramFeature> features, [double threshold = 0.5]) {
    Map<String, dynamic> get(Map<String, dynamic> acc, NgramFeature feature) {
      final NgramFeatureWithDistance f = NgramFeatureWithDistance(
        char: feature.char,
        features: feature.features,
        distance: acc['distance'] as int,
      );
      final double prob = probab(f);
      final bool willBreak = prob > threshold;
      final int distance = willBreak ? 0 : (acc['distance'] as int) + 1;
      return {
        'value': [...(acc['value'] as List<double>), prob],
        'distance': distance,
      };
    }

    return (features.fold({'value': <double>[], 'distance': 0}, get)['value']
        as List<double>);
  }

  return fn;
}

final ProbaPredictorFn predictProba =
    probaPredictor(model['weight'], model['config']['scale']);

PredictorFn predictor(Map<String, dynamic> weight, int scale) {
  final ProbaPredictorFn predictProba = probaPredictor(weight, scale);

  List<bool> fn(Iterable<NgramFeature> features, [double threshold = 0.5]) {
    return predictProba(features, threshold).map((x) => x > threshold).toList();
  }

  return fn;
}

final PredictorFn predict =
    predictor(model['weight'], model['config']['scale']);
