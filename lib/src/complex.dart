import 'dart:math' as math;
part 'operations.dart';

class Complex<T extends num, E extends num> extends Object {
  factory Complex.parse(String source) {
    final parsed = tryPars<T, E>(source);
    assert(parsed != null);
    return parsed!;
  }

  factory Complex([T? real, E? imaginary]) {
    final i = real ?? 0 as T;
    final j = imaginary ?? 0 as E;
    return Complex._(i, j);
  }

  const Complex._(this._real, this._img);
  final T _real;
  final E _img;

  T get real => _real;
  E get imaginary => _img;

  static Complex<R, I>? tryPars<R extends num, I extends num>(String source) {
    final split = _spliter(source);
    var r = 0 as R;
    var j = 0 as I;

    assert(split.isNotEmpty || split.length == 2);

    r = _typeParsing<R>(split[0]);

    if (split.length == 2) {
      //
      j = _typeParsing<I>(split[split.length - 1]);

      return Complex<R, I>(r, j);
    }
  }

  Complex operator +(Complex other) {
    final iTotal = real + other.real;
    final jTotal = imaginary + other.imaginary;
    return Complex(iTotal, jTotal);
  }

  Complex operator -(Complex other) {
    final iTotal = real - other.real;
    final jTotal = imaginary - other.imaginary;
    return Complex(iTotal, jTotal);
  }

  Complex operator *(Complex other) {
    final iTotal = real * other.real - imaginary * other.imaginary;
    final jTotal = real * other.imaginary + imaginary * other.real;
    return Complex(iTotal, jTotal);
  }

  Complex operator /(Complex other) {
    final denominator = math.pow(other.real, 2) + math.pow(other.imaginary, 2);
    final iTotal =
        (real * other.real + imaginary * other.imaginary) / denominator;
    final jTotal =
        (imaginary * other.real - real * other.imaginary) / denominator;
    return Complex(iTotal, jTotal);
  }

  Complex<R, I> asType<R extends num, I extends num>() {
    return Complex<R, I>();
  }

  @override
  String toString() => '$_real${_img > -1 ? "+" : ""}${_img}i';
}
