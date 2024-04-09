<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# Japanese Word Tokenizer

A lightweight Japanese word tokenizer library for Dart and Flutter based on wakachigaki.

## Features

- Tokenizes Japanese text into individual words
- Lightweight and fast
- Easy to use and integrate into Dart and Flutter projects
- Based on the [wakachigaki](https://github.com/yuhsak/wakachigaki-py) tokenizer algorithm by [Yushak Inoue](https://github.com/yuhsak)

## Installation

Add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  japanese_word_tokenizer: ^0.0.3

```

Sample usage

Import the package in your Dart code:

```
import 'package:japanese_word_tokenizer/japanese_word_tokenizer.dart';
```

In your main.dart

```
void main() {
  String text = 'ここでテキストを分かち書きします';
  List<dynamic> tokens = tokenize(text);
  print(tokens);
}
```

Sample output

```
[ここで, テキスト, を, 分か, ち, 書き, します]
```
