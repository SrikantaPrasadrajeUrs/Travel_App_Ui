

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
      debugShowCheckedModeBanner: false,
      home: Home(

      ),
    );
  }
}

