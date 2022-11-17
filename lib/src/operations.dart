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
        throw Exception();
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
