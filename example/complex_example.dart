import 'package:complex_num/complex.dart';

void main() {
  final c1 = Complex(7, 5.5).phase();
  final c2 = Complex<int, double>(8, 3).exp();
  final c3 = Complex(5, 2).cos();
  final c4 = Complex(5, 2).sin();
  // final c4 = Complex.parse('5+6i');
  print(c1);
  print(c2);
  print(c3);
  print(c4);
}
