import 'package:flutter/material.dart';

const smallTextStyle = TextStyle(
  fontSize: 12,
);
const mediumTextStyle = TextStyle(
  fontSize: 14,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w300,
);

const largeTextStyle = TextStyle(
  fontSize: 18,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w700,
);

final buttonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
      side: const BorderSide(color: Colors.red),
    ),
  ),
);
