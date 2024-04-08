import 'dart:math';

double sigmoid(double v) {
  return 1 / (1 + exp(-v));
}
