import 'dart:ui';

Color yellowScheme = const Color.fromARGB(255, 237, 248, 211);
Color darkScheme = const Color.fromARGB(255, 46, 50, 39);

String cutTo(String? input) {
  if (input == null || !input.contains('@gmail.com')) {
    return '';
  }
  final index = input.indexOf('@gmail.com');
  return index != -1 ? input.substring(0, index) : input;
}
