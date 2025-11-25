

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_b3/views/home.dart';
import 'firebase_options.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  uploadData();
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
      home: Home(),
    );
  }
}

void uploadData()async{
  final placesStr = await rootBundle.loadString("assets/data/places.json");
  final places = jsonDecode(placesStr)['places'] as List;
  final instance = FirebaseFirestore.instance;
  CollectionReference placesCollection = instance.collection("places");
  final batch = instance.batch();
  for(var place in places){
    final docRef = placesCollection.doc(place['id']); // create a document
    batch.set(docRef, place);
  }
  await batch.commit();
}

