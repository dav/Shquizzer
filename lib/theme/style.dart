import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    // This is the theme of your application.
    //
    // Try running your application with "flutter run". You'll see the
    // application has a blue toolbar. Then, without quitting the app, try
    // changing the primarySwatch below to Colors.green and then invoke
    // "hot reload" (press "r" in the console where you ran "flutter run",
    // or simply save your changes to "hot reload" in a Flutter IDE).
    // Notice that the counter didn't reset back to zero; the application
    // is not restarted.
    primarySwatch: Colors.lightBlue,
    // primaryColor: Colors.white,
    // accentColor: Colors.orange,
    // hintColor: Colors.white,
    // dividerColor: Colors.white,
    // buttonColor: Colors.white,
    // scaffoldBackgroundColor: Colors.black,
    // canvasColor: Colors.black,
    disabledColor: const Color(0xFFEEEEEE),
  );
}
