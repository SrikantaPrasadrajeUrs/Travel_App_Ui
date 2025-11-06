

import 'package:flutter/material.dart';
import 'package:flutter_b3/views/home.dart';
import 'package:flutter_b3/views/splash.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          outlineBorder: BorderSide(color: Color.fromRGBO(210, 210, 210, 1)),
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(20),
          //   borderSide: BorderSide(color: Colors.green),
          // ),
          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(20),
          //   borderSide: BorderSide(color: Colors.green)),
          // enabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(20),
          //   borderSide: BorderSide(color: Colors.green),
          // )
        )
      ),
      debugShowCheckedModeBanner: false,
      home: Home(

      ),
    );
  }
}

