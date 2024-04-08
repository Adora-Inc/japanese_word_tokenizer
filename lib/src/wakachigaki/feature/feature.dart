import 'package:japanese_word_tokenizer/src/wakachigaki/feature/chart_type.dart';
import 'package:japanese_word_tokenizer/src/wakachigaki/hash/hash.dart';
import 'package:japanese_word_tokenizer/src/wakachigaki/model/model.dart';
import 'package:japanese_word_tokenizer/src/wakachigaki/utils/ngram.dart';
import 'package:japanese_word_tokenizer/src/wakachigaki/utils/normalize.dart';

const List<String> markers = [
  'B',
  'D',
  'E',
  'F',
  'G',
  'I',
  'J',
  'L',
  'M',
  'P',
  'Q',
  'R',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z',
];

class NgramFeatureItem {
  final String kind;
  final int size;
  final int offset;
  final String value;

  NgramFeatureItem({
    required this.kind,
    required this.size,
    required this.offset,
    required this.value,
  });
}

class NgramFeature {
  final String char;
  final List<NgramFeatureItem> features;

  NgramFeature({
    required this.char,
    required this.features,
  });
}

typedef FeaturerFn = List<NgramFeature> Function(String);

FeaturerFn featurer(int nBuckets, int size, int offset) {
  List<String> prefix = markers.sublist(0, offset);
  List<String> suffix = markers.reversed.toList().sublist(0, offset);
  Function h = strToHash(nBuckets);

  List<NgramFeature> fn(String text) {
    String source = normalize(text);
    List<String> chars = source.split('');
    NgramFn Function(int p1) ngramByChars =
        ngram(prefix + source.toLowerCase().split('') + suffix);
    NgramFn Function(int p1) ngramByTypes =
        ngram(prefix + chars.map(getCharType).toList() + suffix);

    NgramFeature get(MapEntry<int, String> item) {
      int i = item.key;
      String char = item.value;
      int index = i + offset;
      NgramFn ngramByCharsAt = ngramByChars(index);
      NgramFn ngramByTypesAt = ngramByTypes(index);

      NgramFeature getSize(NgramFeature acc, int s) {
        NgramFeature getOffset(NgramFeature acc, int o) {
          String t = ngramByTypesAt(s, o);
          String hashValue = h(ngramByCharsAt(s, o));
          return NgramFeature(
            char: acc.char,
            features: [
              ...acc.features,
              NgramFeatureItem(kind: 'type', size: s, offset: o, value: t),
              NgramFeatureItem(
                  kind: 'hash', size: s, offset: o, value: hashValue),
            ],
          );
        }

        return List.generate(offset * 2 + 2 - s, (o) => o - offset)
            .fold(acc, getOffset);
      }

      return List.generate(size, (s) => s + 1)
          .fold(NgramFeature(char: char, features: []), getSize);
    }

    return chars.asMap().entries.map(get).toList();
  }

  return fn;
}

final Map<String, dynamic> config = model['config'];
final FeaturerFn features =
    featurer(config['n_buckets'], config['size'], config['offset']);
