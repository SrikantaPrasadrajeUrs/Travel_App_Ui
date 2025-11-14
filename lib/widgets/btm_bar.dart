import 'package:flutter/material.dart';

class BtmBar extends StatelessWidget {
  const BtmBar({super.key});

  @override
  Widget build(BuildContext context) {
    final images = [
      'assets/images/icon home.png',
      'assets/images/icon clock.png',
      'assets/images/icon heart.png',
      'assets/images/icon user.png',
    ];
    // map - array
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: images.map((imagePath)=>Image.asset(imagePath, width: 20,)).toList(),
      ),
    );
  }
}
