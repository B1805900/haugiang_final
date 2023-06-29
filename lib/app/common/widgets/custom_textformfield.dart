import 'package:flutter/material.dart';

import '../constant.dart';

InputDecoration buildDecorationTextFormField(
    {required String hintText, IconData? icon}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 10),
    hintText: hintText,
    hintStyle: const TextStyle(color: Colors.black),
    focusColor: iconColor,
    prefixIcon: Icon(
      icon,
      color: iconColor,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: primaryColor,
        width: 2.0, // Độ dày của viền
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(color: primaryColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(color: secondaryColor),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(color: secondaryColor),
    ),
  );
}
