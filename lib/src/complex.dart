// Copyright (c) 2022, Mohamed Lotfy.
// for details. All rights reserved. Use of this source code is governed by a
//  BSD 3-clause license that can be found in the LICENSE file.
import 'dart:math' as math;

part 'complex_base.dart';
part 'functions.dart';

///
/// Representation of Dart imaginary numbers containing complex specific
/// constants and operations and specializations of operations

class Complex<T extends num, E extends num> implements _BaseComplex<T, E> {
  const Complex._(this._real, this._img);

  /// Initializing a complex number
  ///
  /// The first parameter is the real number and second is the imaginary part
  /// It can be instantiate with no parameters that equals to 0+0i of type num
  /// Example:
  /// ```dart
  ///final c1 = Complex(7, 5.5);
  ///final c2 = Complex();
  ///final c3 = Complex(5);
  /// ```

  factory Complex([T? real, E? imaginary]) {
    final r = real ?? (T == double ? 0.0 : 0) as T;
    final i = imaginary ?? (E == double ? 0.0 : 0) as E;
    return Complex._(r, i);
  }

  /// Parse [source] as a Complex literal and return its value.
  ///
  /// Accepts an optional sign (`+` or `-`) followed by The imaginary part
  /// A floating-point representation is composed of a mantissa and an optional
  /// The [source] must not be `null`.
  ///
  /// white-spaces is ignored.
  ///
  /// If the [source] string is not a valid Complex literal, the []
  /// is called with the [source] as argument, and its return value is
  /// used instead.
  /// Throws a [] if the [source] string is not valid
  /// and no `onError` is provided.
  ///
  /// Examples of accepted strings:
  /// ```
  ///'3.14'
  /// '  3'
  /// '1+5i'
  /// '.0'
  /// '  1+ 5i '
  /// '6i'
  ///
  /// ```
  /// Instead of `Complex.parse(string, (string) { ... })`,
  /// you should use `Complex.tryParse(string) ?? (...)`.
  factory Complex.parse(String source) {
    final parsed = tryParse<T, E>(source);
    assert(parsed != null);
    return parsed!;
  }

  /// Floating-point positive infinity. Equivalent to
  /// ```dart
  /// Complex<double, double>(double.infinity, 0.0)
  /// ```.
  static Complex<double, double> infinite() {
    return Complex<double, double>(double.infinity, 0.0);
  }

  /// Complex number with zero real part and positive infinity imaginary part.
  /// Equivalent to
  /// ```dart
  /// Complex<double, double>(0.0, double.infinity)
  /// ```.
  static Complex<double, double> infinitei() {
    return Complex<double, double>(0.0, double.infinity);
  }

  /// A floating-point “not a number” (NaN) value. Equivalent to
  /// ```dart
  /// Complex<double, double>(double.nan, 0.0)
  /// ```.

  static Complex<double, double> nan() {
    return Complex<double, double>(double.nan, 0.0);
  }

  /// Complex number with zero real part and NaN imaginary part.
  ///  Equivalent to
  /// ```dart
  /// Complex<double, double>(0.0, double.nan)
  /// ```.

  static Complex<double, double> nani() {
    return Complex<double, double>(0.0, double.nan);
  }

  /// Parse [source] as a complex literal and return its value.
  ///
  /// Like [Complex.parse], except that this function returns `null`
  /// for invalid inputs instead of throwing.
  ///
  /// Example:
  /// ```dart
  /// var value = Complex.tryParse('3.14'); // 3.14+0i
  /// value = Complex.tryParse('  3'); // 3+0i
  /// value = Complex.tryParse('1+5i'); // 1+5i
  /// value = Complex.tryParse('.0'); // 0.0+0i
  /// value = Complex.tryParse('  1+ 5i '); // 1+5i
  /// value = Complex.tryParse('6i'); // 0+6i
  /// value = Complex.tryParse('a'); // null
  /// value = Complex.tryParse('0xFF'); // 255+0𝑖
  /// ```
  static Complex<R, I>? tryParse<R extends num, I extends num>(String source) {
    final split = _spliter(source);
    R? r;
    I? i;
    if (split.isEmpty || split.length != 2) {
      return null;
    }

    r = _typeParsing<R>(split[0]);

    i = _typeParsing<I>(split[split.length - 1]);

    if (r == null || i == null) {
      return null;
    }

    return Complex<R, I>(r, i);
  }

  final T _real;
  final E _img;

  /// returns the real part value
  T get real => _real;

  /// returns the imaginary part value without the i symbol
  E get imaginary => _img;

  @override
  Complex operator +(Complex other) {
    final iTotal = real + other.real;
    final jTotal = imaginary + other.imaginary;
    return Complex(iTotal, jTotal);
  }

  @override
  Complex operator -(Complex other) {
    final iTotal = real - other.real;
    final jTotal = imaginary - other.imaginary;
    return Complex(iTotal, jTotal);
  }

  @override
  Complex operator *(Complex other) {
    final iTotal = real * other.real - imaginary * other.imaginary;
    final jTotal = real * other.imaginary + imaginary * other.real;
    return Complex(iTotal, jTotal);
  }

  @override
  Complex operator /(Complex other) {
    final denominator = math.pow(other.real, 2) + math.pow(other.imaginary, 2);
    final iTotal =
        (real * other.real + imaginary * other.imaginary) / denominator;
    final jTotal =
        (imaginary * other.real - real * other.imaginary) / denominator;
    return Complex(iTotal, jTotal);
  }

  /// casting the [Complex] to specific type
  @override
  Complex<R, I> asType<R extends num, I extends num>() {
    final R r;
    final I i;

    if (R == T) {
      r = real as R;
    } else {
      var temp = real is double && R != double ? real.toInt() : real;
      r = _typeParsing<R>('$temp')!;
    }

    if (I == E) {
      i = imaginary as I;
    } else {
      var temp = imaginary is double && R != double ? imaginary.toInt() : real;

      i = _typeParsing<I>('$temp')!;
    }
    return Complex<R, I>(r, i);
  }

  /// Return true if both the real and imaginary parts of [Complex] are finite,
  /// otherwise return false.
  @override
  bool isFinite() {
    return real.isFinite || imaginary.isFinite;
  }

  /// Return true if either the real or the imaginary part of [Complex] is
  /// an infinity, otherwise return false.
  @override
  bool isInfinite() {
    return real.isInfinite || imaginary.isInfinite;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Complex<T, E> && other._real == _real && other._img == _img;
  }

  /// Return true if the values [Complex] and [other] are close to each other
  /// and false otherwise.
  /// Whether or not two values are considered close is determined according
  /// to given absolute and relative tolerances.
  /// [relTol] is the relative tolerance – it is the maximum allowed difference
  /// between [Complex] and [other], relative to
  /// the larger absolute value of [Complex] and [other]. For
  /// example, to set a tolerance of 5%, pass [relTol]:0.05.
  /// The default tolerance
  /// is 1e-09, which assures that the two values are the same within
  /// about 9 decimal digits. [relTol] must be greater than zero
  /// [absTotal] is the minimum absolute tolerance – useful for
  /// comparisons near zero [absTotal] must be at least zero.
  @override
  bool isClose(Complex other, {double relTol = 1e-09, double absTotal = 0.0}) {
    return abs(this - other) <=
        math.max(relTol * math.max(abs(this), abs(other)), absTotal);
  }

  /// Return true if either the real or the imaginary part of [Complex] is a
  /// NaN, and false otherwise.
  @override
  bool isNaN() {
    return real.isNaN || imaginary.isNaN;
  }

  /// Provide a representation of this [Complex] value.
  ///
  /// The representation is a number literal
  /// to the representation's mathematical value is this [Complex].
  ///
  ///
  /// For all complex, `c`, converting to a string and parsing the string back
  /// gives the same value again: `c == Complex.parse(c.toString())`.

  @override
  String toString() => '$_real${_img.sign == -1 ? '' : '+'}$_img\u{1D456}';

  /// Returns a hash code for a both real and imaginary values.
  ///
  /// The hash code is compatible with equality.
  /// No guarantees are made about the hash code of NaN values.
  @override
  int get hashCode => _real.hashCode ^ _img.hashCode;
}
