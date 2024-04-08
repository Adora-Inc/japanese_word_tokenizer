import 'dart:convert';

import 'package:japanese_word_tokenizer/src/wakachigaki/hash/crc32.dart';

Function strToHash(int nBuckets) {
  return (String text) {
    List<int> bytes = utf8.encode(text);
    int hash = crc32(bytes) % nBuckets;
    return hash.toRadixString(16).padLeft(8, '0').toLowerCase();
  };
}
