part of 'complex.dart';

abstract class _BaseComplex<T extends num, E extends num> extends Object {
  Complex operator +(Complex other);

  Complex operator -(Complex other);

  Complex operator *(Complex other);

  Complex operator /(Complex other);

  Complex<R, I> asType<R extends num, I extends num>();

  bool isFinite();

  bool isInfinite();

  bool isNaN();

  bool isNaNi();

  bool isClose(Complex other, {double relTol = 1e-09, double absTotal = 0.0});
}
