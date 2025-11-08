import 'package:flutter/material.dart';

class UiBtmBar extends StatelessWidget {
  const UiBtmBar({super.key});

  static const List<String> icons = [
    "assets/images/icon home.png",
    "assets/images/icon clock.png",
    "assets/images/icon heart.png",
    "assets/images/icon user.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: icons.map((icon)=>Image.asset(icon, height: 22)).toList(),
      ),
    );
  }

}
