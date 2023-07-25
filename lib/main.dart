import 'package:flutter/material.dart';
import 'package:webflutter/screen/confirm_password.dart';
import 'package:webflutter/screen/login_screen.dart';
import 'package:webflutter/screen/reset_password.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      // home: ConfirmPasswordScreen(),
    );
  }
}