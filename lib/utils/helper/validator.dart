import 'package:flutter/services.dart';

enum InputFormatType { name, phoneNumber, email, password }

class Validator {
  Validator.__();

  static List<TextInputFormatter>? inputFormatter(InputFormatType type) {
    List<TextInputFormatter>? val;
    switch (type) {
      case InputFormatType.phoneNumber:
        val = [
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        ];
        break;

      case InputFormatType.password:
        val = [
          FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z@]")),
        ];
        break;
      case InputFormatType.name:
        val = [FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"))];
        break;
      case InputFormatType.email:
        val = [FilteringTextInputFormatter.deny(RegExp(r'[- /+?:;*#$%^&*()]'))];
        break;
    }
    return val;
  }
}
