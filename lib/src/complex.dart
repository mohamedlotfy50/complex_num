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
  String toString() => '($_real${_img > -1 ? "+" : ""}${_img}i)';
  double phase() {
    return math.atan2(imaginary, real);
  }

  List<num> polar() {
    var modulus = abs();
    var phi = phase();
    var pair = [modulus, phi];

    return List<num>.unmodifiable(pair);
  }

  num abs() {
    return math.sqrt(math.pow(real, 2) + math.pow(imaginary, 2));
  }

  Complex<R, I> rect<R extends num, I extends num>() {
    var r = abs();
    var phi = phase();
    var rl = r * math.cos(phi) as R;
    var img = r * math.sin(phi) as I;
    return Complex<R, I>(rl, img);
  }

  bool isFinite() {
    return real.isFinite && imaginary.isFinite;
  }

  bool isInfinite() {
    return real.isInfinite && imaginary.isInfinite;
  }

  bool isNaN() {
    return real.isNaN && imaginary.isNaN;
  }

  Complex<num, num> exp() {
    var rl = math.exp(real) * math.cos(imaginary);
    var img = math.exp(real) * math.sin(imaginary);

    return Complex<num, num>(rl, img);
  }

  Complex<num, num> sqrt() {
    var r = math.sqrt((abs() + real) / 2);
    var i = (imaginary / imaginary.abs()) * math.sqrt((abs() - real) / 2);
    return Complex<num, num>(r, i);
  }

  Complex<num, num> log() {
    var r = math.log((abs()));
    var i = phase();
    return Complex<num, num>(r, i);
  }

  Complex<num, num> cosh() {
    var r = _cosh(real) * math.cos(imaginary);
    var i = _sinh(real) * math.sin(imaginary);
    return Complex<num, num>(r, i);
  }

  Complex<num, num> sinh() {
    var r = _sinh(real) * math.cos(imaginary);
    var i = _cosh(real) * math.sin(imaginary);
    return Complex<num, num>(r, i);
  }

  Complex<num, num> tanh() {
    return sinh() / cosh();
  }

  Complex<num, num> acosh() {
    throw UnimplementedError();
  }

  Complex<num, num> asinh() {
    throw UnimplementedError();
  }

  Complex<num, num> atanh() {
    throw UnimplementedError();
  }

  bool isClose() {
    throw UnimplementedError();
  }

  Complex<num, num> cos() {
    var r = math.cos(real) * _cosh(imaginary);
    var i = math.sin(real) * _sinh(imaginary);
    return Complex<num, num>(r, i);
  }

  Complex<num, num> sin() {
    var r = math.sin(real) * _cosh(imaginary);
    var i = math.cos(real) * _sinh(imaginary);
    return Complex<num, num>(r, i);
  }

  Complex<num, num> tan() {
    var base = math.cos(2 * real) + _cosh(2 * imaginary);
    var r = math.sin(2 * real) / base;
    var i = _sinh(2 * imaginary) / base;
    return Complex<num, num>(r, i);
  }

  Complex<num, num> acos() {
    var val = this + Complex(0, 1) * (Complex(1, 0) - this * this).sqrt();
    return val.log() * Complex(0, -1);
  }

  Complex<num, num> asin() {
    var val = Complex(0, 1) * this + (Complex(1, 0) - this * this).sqrt();
    return val.log() * Complex(0, -1);
  }

  Complex<num, num> atan() {
    var val = ((Complex(0, 1) + this) / (Complex(0, 1) - this)).log();
    return val * Complex(0, 1 / 2);
  }

  Complex<num, num> log10() {
    var base = math.log(10);
    var r = math.log((abs())) / base;
    var i = phase() / base;
    return Complex<num, num>(r, i);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Complex<T, E> && other._real == _real && other._img == _img;
  }

  @override
  int get hashCode => _real.hashCode ^ _img.hashCode;
}
