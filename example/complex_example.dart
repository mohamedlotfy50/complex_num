import 'package:complex/complex.dart';

void main() {
  final sum = Complex(2, 7) + Complex(3, -4);
  final sub = Complex(9, 5) - Complex(4, 7);
  final mult = Complex(3, 2) * Complex(5, 6);
  final div = Complex(3, 2) / Complex(4, -5);
  print(sum.toString());
  print(sub.toString());
  print(mult.toString());
  print(div.toString());
}
