part of 'complex.dart';

List<String> _spliter(String source) {
  source = source.trim().toLowerCase();
  final len = source.length;
  final data = <String>[];
  var i = 0;

  while (i < len) {
    if (source[i] == '+' || source[i] == '-') {
      if (i == len - 1) {
        data.add(source.substring(0, i));
        break;
      } else if (source[len - 1] == 'i') {
        data
          ..add(source.substring(0, i))
          ..add(source.substring(i, len - 1));

        break;
      } else {
        break;
      }
    }
    i += 1;
  }
  if (data.isEmpty) {
    data.add(source);
  }

  return data;
}

E _typeParsing<E extends num>(String source) {
  final E? temp1;

  if (E == int) {
    temp1 = int.tryParse(source) as E?;
  } else if (E == double) {
    temp1 = double.tryParse(source) as E?;
  } else if (E == num) {
    temp1 = num.tryParse(source) as E?;
  } else {
    throw Exception();
  }
  return temp1!;
}

num _cosh(num x) {
  return (math.exp(x) + math.exp(-x)) / 2;
}

num _sinh(num x) {
  return (math.exp(x) - math.exp(-x)) / 2;
}

Complex<num, num> exp(Complex complex) {
  var rl = math.exp(complex.real) * math.cos(complex.imaginary);
  var img = math.exp(complex.real) * math.sin(complex.imaginary);

  return Complex<num, num>(rl, img);
}

Complex<num, num> sqrt(Complex complex) {
  var r = math.sqrt((abs(complex) + complex.real) / 2);
  var i = (complex.imaginary / complex.imaginary.abs()) *
      math.sqrt((abs(complex) - complex.real) / 2);
  return Complex<num, num>(r, i);
}

Complex<num, num> log(Complex complex) {
  var r = math.log((abs(complex)));
  var i = phase(complex);
  return Complex<num, num>(r, i);
}

Complex<num, num> cosh(Complex complex) {
  var r = _cosh(complex.real) * math.cos(complex.imaginary);
  var i = _sinh(complex.imaginary) * math.sin(complex.imaginary);
  return Complex<num, num>(r, i);
}

Complex<num, num> sinh(Complex complex) {
  var r = _sinh(complex.real) * math.cos(complex.imaginary);
  var i = _cosh(complex.real) * math.sin(complex.imaginary);
  return Complex<num, num>(r, i);
}

Complex<num, num> tanh(Complex complex) {
  return sinh(complex) / cosh(complex);
}

Complex<num, num> cos(Complex complex) {
  var r = math.cos(complex.real) * _cosh(complex.imaginary);
  var i = math.sin(complex.real) * _sinh(complex.imaginary);
  return Complex<num, num>(r, i);
}

Complex<num, num> sin(Complex complex) {
  var r = math.sin(complex.real) * _cosh(complex.imaginary);
  var i = math.cos(complex.real) * _sinh(complex.imaginary);
  return Complex<num, num>(r, i);
}

Complex<num, num> tan(Complex complex) {
  var base = math.cos(2 * complex.real) + _cosh(2 * complex.imaginary);
  var r = math.sin(2 * complex.real) / base;
  var i = _sinh(2 * complex.imaginary) / base;
  return Complex<num, num>(r, i);
}

Complex<num, num> acos(Complex complex) {
  var val = complex + Complex(0, 1) * sqrt(Complex(1, 0) - complex * complex);
  return log(val) * Complex(0, -1);
}

Complex<num, num> asin(Complex complex) {
  var val = Complex(0, 1) * complex + sqrt(Complex(1, 0) - complex * complex);
  return log(val) * Complex(0, -1);
}

Complex<num, num> atan(Complex complex) {
  var val = ((Complex(0, 1) + complex) / log(Complex(0, 1) - complex));
  return val * Complex(0, 1 / 2);
}

double phase(Complex complex) {
  return math.atan2(complex.imaginary, complex.real);
}

List<num> polar(Complex complex) {
  var modulus = abs(complex);
  var phi = phase(complex);
  var pair = [modulus, phi];

  return List<num>.unmodifiable(pair);
}

double abs(Complex complex) {
  return math.sqrt(math.pow(complex.real, 2) + math.pow(complex.imaginary, 2));
}

Complex<R, I> rect<R extends num, I extends num>(Complex complex) {
  var r = abs(complex);
  var phi = phase(complex);
  var rl = r * math.cos(phi) as R;
  var img = r * math.sin(phi) as I;
  return Complex<R, I>(rl, img);
}

Complex<num, num> log10(Complex complex) {
  var base = math.log(10);
  var r = math.log((abs(complex))) / base;
  var i = phase(complex) / base;
  return Complex<num, num>(r, i);
}

Complex<num, num> acosh(Complex complex) {
  var val = complex + sqrt(complex * complex - Complex(1, 0));

  return log(val);
}

Complex<num, num> asinh(Complex complex) {
  var val = sqrt(complex + (complex * complex + Complex(1, 0)));

  return log(val);
}

Complex<num, num> atanh(Complex complex) {
  var val = (Complex(1, 0) + complex) / (Complex(1, 0) - complex);

  return log(val) * Complex(1 / 2);
}
