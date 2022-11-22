# ComplexNum

A Typed Complex Number library implements mathematical functions for imaginary numbers.The Complex Class accept integers, floating-point numbers or complex numbers as arguments.
Like Other Dart data types Complex class extends **Object** class
 

## Features

### polar coordinates

- [X] Phase
- [X] Modulus
- [X] Rectangular

### Power and logarithmic functions

- [X] Exponential
- [X] Log == Ln
- [X] Log with base 10
- [X] Square root

### Trigonometric functions

- [X] Sine
- [X] Cosine
- [X] Tangent
- [X] Inverse Sine
- [X] Inverse Cosine
- [X] Inverse Tangent

### Hyperbolic functions

- [X] Hyperbolic sine
- [X] Hyperbolic Cosine
- [X] Hyperbolic Tangent
- [X] Inverse Hyperbolic sine
- [X] Inverse Hyperbolic Cosine
- [X] Inverse Hyperbolic Tangent

### Classification functions

- [X] Finite
- [X] Infinite
- [X] NaN
- [X] Closeness

## Getting started

### Initialization

```dart 
  final c1 = Complex(7, 5.5);
  final c2 = Complex();
  final c3 = Complex(5);
```
Ouputs

```dart
(7+5.5𝑖)
(0+0𝑖)
(5+0𝑖)

```
And the type is Detected autmaticly

```dart
Complex<int, double>
Complex<num, num>
Complex<int, num>

```
You can also explicitly define the type

```dart 
  final c = Complex<double, double>();

```
The output would be 

```dart
(0+0.0𝑖)

```
### Parsing strings


```dart
   var c1 = Complex.parse('3.14'); 
   var c2 = Complex.tryParse('  3'); 
   var c3 = Complex.tryParse('1+5i'); 
   var c4 = Complex.tryParse('.0');
   var c5 = Complex.tryParse('  1+ 5i '); 
   var c6 = Complex.tryParse('6i'); 
   var c7 = Complex.tryParse('a'); 
   var c8 = Complex.tryParse('0xFF'); 

```

Ouputs

```dart
3.14+0i
3+0i
1+5i
0.0+0i
1+5i
0+6i
null
255+0𝑖
```


### Arithmetic operations


```dart
 final c2 = Complex<int, double>() +
      Complex(1, 5) * Complex<int, double>(3, 2) / Complex(10, 10);
```
Outputs

```dart
(0.5+1.2𝑖)

```

### Other Operations

```dart
  final c1 = Complex(7, 5.5).phase();
  final c2 = Complex<int, double>(8, 3).exp();
  final c3 = Complex(5, 2).cos();
  final c4 = Complex(5, 2).sin();
```
Outputs

```dart

0.6659692373791098
(-2951.1260398524787+420.67281515745424𝑖)
(1.0671926518731156-3.4778844858991573𝑖)
(-3.6076607742131563+1.0288031496599335𝑖)

```

## License

[BSD 3-clause license](https://github.com/mohamedlotfy50/complex_num/blob/main/LICENSE)
