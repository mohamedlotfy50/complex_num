part of 'complex.dart';

List<String> _spliter(String source) {
  source = source.trim().toLowerCase();
  var data = <String>[];
  var len = source.length;
  var lastIndex = source[len - 1];
  if (lastIndex == 'i' || lastIndex == '\u{1D456}') {
    source = source.substring(0, len - 1);
    if (source.isEmpty) {
      data
        ..add('0')
        ..add('1');
    } else {
      for (var i = 0; i < len - 2; i++) {
        if (source[i] == '-' || source[i] == '+') {
          data
            ..add(source.substring(0, i))
            ..add(source.substring(i + 1));
          break;
        } else if (i == len - 3) {
          data
            ..add('0')
            ..add(source);
        }
      }
    }
  } else {
    data
      ..add(source)
      ..add('0');
  }

  return data;
}

E? _typeParsing<E extends num>(String source) {
  E? temp1;
  if (E == int) {
    temp1 = int.tryParse(source) as E?;
  } else if (E == double) {
    temp1 = double.tryParse(source) as E?;
  } else if (E == num) {
    temp1 = num.tryParse(source) as E?;
  }
  return temp1;
}

num _cosh(num x) {
  return (math.exp(x) + math.exp(-x)) / 2;
}

num _sinh(num x) {
  return (math.exp(x) - math.exp(-x)) / 2;
}

/// Return e raised to the power [complex],
/// where e is the base of natural logarithms.

Complex<num, num> exp(Complex complex) {
  var rl = math.exp(complex.real) * math.cos(complex.imaginary);
  var img = math.exp(complex.real) * math.sin(complex.imaginary);

  return Complex<num, num>(rl, img);
}

/// Return the square root of [complex]. This has the same branch cut as [log].

Complex<num, num> sqrt(Complex complex) {
  var r = math.sqrt((abs(complex) + complex.real) / 2);
  var i = (complex.imaginary / complex.imaginary.abs()) *
      math.sqrt((abs(complex) - complex.real) / 2);
  return Complex<num, num>(r, i);
}

/// returns the natural logarithm of [complex]. There is one branch cut,
/// from 0 along the negative real axis to -∞, continuous from above.
Complex<num, num> log(Complex complex) {
  var r = math.log((abs(complex)));
  var i = phase(complex);
  return Complex<num, num>(r, i);
}

/// Return the sine of [complex].
///
Complex<num, num> sin(Complex complex) {
  var r = math.sin(complex.real) * _cosh(complex.imaginary);
  var i = math.cos(complex.real) * _sinh(complex.imaginary);
  return Complex<num, num>(r, i);
}

/// Return the cosine of [complex].
///
Complex<num, num> cos(Complex complex) {
  var r = math.cos(complex.real) * _cosh(complex.imaginary);
  var i = math.sin(complex.real) * _sinh(complex.imaginary);
  return Complex<num, num>(r, i);
}

/// Return the tangent of [complex].
Complex<num, num> tan(Complex complex) {
  var base = math.cos(2 * complex.real) + _cosh(2 * complex.imaginary);
  var r = math.sin(2 * complex.real) / base;
  var i = _sinh(2 * complex.imaginary) / base;
  return Complex<num, num>(r, i);
}

/// Return the arc sine of [complex]. This has the same branch cuts as [acos].

Complex<num, num> asin(Complex complex) {
  var val = Complex(0, 1) * complex + sqrt(Complex(1, 0) - complex * complex);
  return log(val) * Complex(0, -1);
}

/// Return the arc cosine of [complex].
/// There are two branch cuts: One extends right from 1 along
/// the real axis to ∞, continuous from below. The other extends left from -1
/// along the real axis to -∞, continuous from above.

Complex<num, num> acos(Complex complex) {
  var val = complex + Complex(0, 1) * sqrt(Complex(1, 0) - complex * complex);
  return log(val) * Complex(0, -1);
}

/// Return the arc tangent of [complex].
/// There are two branch cuts: One extends from 1i along
/// the imaginary axis to ∞i, continuous from the right.
/// The other extends from -1i along the imaginary axis to -∞i,
/// continuous from the left.

Complex<num, num> atan(Complex complex) {
  var val = ((Complex(0, 1) + complex) / log(Complex(0, 1) - complex));
  return val * Complex(0, 1 / 2);
}

/// Return the hyperbolic sine of [complex].
Complex<num, num> sinh(Complex complex) {
  var r = _sinh(complex.real) * math.cos(complex.imaginary);
  var i = _cosh(complex.real) * math.sin(complex.imaginary);
  return Complex<num, num>(r, i);
}

/// Return the hyperbolic cosine of [complex].
Complex<num, num> cosh(Complex complex) {
  var r = _cosh(complex.real) * math.cos(complex.imaginary);
  var i = _sinh(complex.imaginary) * math.sin(complex.imaginary);
  return Complex<num, num>(r, i);
}

/// Return the hyperbolic tangent of [complex].
Complex<num, num> tanh(Complex complex) {
  return sinh(complex) / cosh(complex);
}

/// the angle to the real axis of a line drawn from the point
/// of origin (real,imaginary)
/// returns NaN if one of [complex] values is NaN.
double phase(Complex complex) {
  return math.atan2(complex.imaginary, complex.real);
}

/// combination of modulus [abs] and argument [phase].
List<num> polar(Complex complex) {
  var modulus = abs(complex);
  var phi = phase(complex);
  var pair = [modulus, phi];

  return List<num>.unmodifiable(pair);
}

/// the distance between the origin (0,0) and the [complex] in the complex plane
/// returns Infinity if one of the [complex] values if Infinity
/// returns NaN if one of the [complex] values if NaN.
double abs(Complex complex) {
  return math.sqrt(math.pow(complex.real, 2) + math.pow(complex.imaginary, 2));
}

/// Return the complex number [complex] with
/// polar coordinates [abs] and [phase].
Complex<R, I> rect<R extends num, I extends num>(Complex complex) {
  var r = abs(complex);
  var phi = phase(complex);
  var rl = r * math.cos(phi) as R;
  var img = r * math.sin(phi) as I;
  return Complex<R, I>(rl, img);
}

/// Return the base-10 logarithm of [complex].
///  This has the same branch cut as [log].
Complex<num, num> log10(Complex complex) {
  var base = math.log(10);
  var r = math.log((abs(complex))) / base;
  var i = phase(complex) / base;
  return Complex<num, num>(r, i);
}

/// Return the inverse hyperbolic cosine of [complex].
///  There is one branch cut, extending left from 1 along the real axis to -∞,
/// continuous from above.
Complex<num, num> acosh(Complex complex) {
  var val = complex + sqrt(complex * complex - Complex(1, 0));

  return log(val);
}

/// Return the inverse hyperbolic sine of [complex].
///  There are two branch cuts: One extends from 1i along the
/// imaginary axis to ∞i,
///  continuous from the right. The other extends from -1i along
/// the imaginary axis to -∞i, continuous from the left.
Complex<num, num> asinh(Complex complex) {
  var val = sqrt(complex + (complex * complex + Complex(1, 0)));

  return log(val);
}

/// Return the inverse hyperbolic tangent of [complex].
/// There are two branch cuts: One extends from 1 along the real axis to ∞,
/// continuous from below. The other extends from -1 along the real axis to -∞,
///  continuous from above.
Complex<num, num> atanh(Complex complex) {
  var val = (Complex(1, 0) + complex) / (Complex(1, 0) - complex);

  return log(val) * Complex(1 / 2);
}
