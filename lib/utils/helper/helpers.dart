import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Helpers {
  static Future<bool> isInternetAvailable({bool enableToast = true}) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        if (enableToast) showToast("No Internet");
        return false;
      }
    } on SocketException catch (_) {
      if (enableToast) showToast("No Internet");
      return false;
    }
  }

  static double validateScale(double valArg) {
    double val = 1.0;
    if (valArg <= 1.0) {
      val = 1.0;
    } else if (valArg >= 1.3) {
      val = valArg - 0.2;
    } else if (valArg >= 1.1) {
      val = valArg - 0.1;
    }
    return val;
  }

  static double convertToDouble(var valArg, {bool check = false}) {
    double val = 0.0;
    if (valArg == null) return val;
    switch (valArg.runtimeType) {
      case int:
        val = valArg.toDouble();
        break;
      case String:
        val = double.tryParse(valArg) ?? val;
        break;

      default:
        val = valArg;
    }
    return val;
  }

  static int convertToInt(var valArg, {int defValue = 0}) {
    int val = defValue;
    if (valArg == null) return val;
    switch (valArg.runtimeType) {
      case double:
        return valArg.toInt();

      case String:
        return int.tryParse(valArg) ?? val;

      default:
        return valArg;
    }
  }

  static void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  // static Future flushToast(BuildContext context, {required String msg}) {
  //   return Flushbar(
  //     message: msg,
  //     duration: const Duration(seconds: 2),
  //     titleColor: HexColor('#282C3F').withOpacity(0.95),
  //     margin: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 8.h),
  //   ).show(context);
  // }

  static capitaliseFirstLetter(String? input) {
    if (input != null) {
      return input[0].toUpperCase() + input.substring(1);
    } else {
      return '';
    }
  }

  static String decodeBase64(String? val) {
    String uid = '';
    if (val != null) {
      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      uid = stringToBase64.decode(val);
    }
    return uid;
  }

  static String encodeBase64(String? valArg) {
    String val = '';
    if (valArg != null) {
      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      val = stringToBase64.encode(valArg);
    }
    return val;
  }

  static String removeBracket(List<String>? input) {
    if (input != null && input.isNotEmpty) {
      return input.toString().replaceAll('[', '').replaceAll(']', '');
    }
    return '';
  }

  // static DateTime? convertDateStringToDate(String? string) {
  //   if (string != null) {
  //     return DateFormat("yyyy-MM-dd").parse(string);
  //   } else {
  //     return null;
  //   }
  // }
}

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}
