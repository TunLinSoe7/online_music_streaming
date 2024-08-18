import 'dart:math';

import 'package:flutter/material.dart';

void navigateToScreen(Widget screen,BuildContext context){
  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>screen));
}

String getFirstLetter(String str) {
  if (str.isNotEmpty) {
    return str[0];
  } else {
    return '';
  }
}

Color getRandomColor() {
  final random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
}