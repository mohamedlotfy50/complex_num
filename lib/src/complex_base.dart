part of 'complex.dart';

abstract class _BaseComplex<T extends num, E extends num> extends Object {
  const _BaseComplex();

  Complex operator +(Complex other);

  Complex operator -(Complex other);

  Complex operator *(Complex other);

  Complex operator /(Complex other);

  Complex<R, I> asType<R extends num, I extends num>();

  double phase();

  List<num> polar();

  /// this is modulus
  num abs();

  Complex<R, I> rect<R extends num, I extends num>();

  bool isFinite();

  bool isInfinite();

  bool isNaN();

  bool isNaNi();

  Complex<num, num> exp();

  Complex<num, num> sqrt();

  Complex<num, num> log();

  Complex<num, num> cosh();

  Complex<num, num> sinh();

  Complex<num, num> tanh();

  Complex<num, num> cos();

  Complex<num, num> sin();

  Complex<num, num> tan();

  Complex<num, num> acos();

  Complex<num, num> asin();

  Complex<num, num> atan();

  Complex<num, num> log10();

  Complex<num, num> acosh();

  Complex<num, num> asinh();

  Complex<num, num> atanh();

  bool isClose(Complex other, {double relTol = 1e-09, double absTotal = 0.0});
}
