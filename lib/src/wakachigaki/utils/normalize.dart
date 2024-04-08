import 'dart:convert';

String normalize(String text) {
  return utf8.decode(utf8.encode(text), allowMalformed: true);
}
