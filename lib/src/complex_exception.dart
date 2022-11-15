import 'package:complex/complex.dart';

class ComplexException implements Exception {
  const ComplexException(this.message);

  final String message;
}
