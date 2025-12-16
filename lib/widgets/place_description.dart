import 'package:flutter/material.dart';

class PlaceDescription extends StatelessWidget {
  final Map<String,dynamic> place;

  const PlaceDescription({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    print(place);
    return const Placeholder();
  }
}
