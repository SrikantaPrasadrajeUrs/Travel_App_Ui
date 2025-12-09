import 'dart:ui';

import 'package:flutter/material.dart';

// Columns - vertical, Rows - Horizontal, Stack - One element on top of another

class PlaceView extends StatelessWidget {
  final Map<String, dynamic> place;
  const PlaceView({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Image.network(
            errorBuilder: (context, error, stackTrace){
              return Image.asset("assets/images/nature3.jpeg");
            },
            place['images'][0],
            width: 210,
            height: 390,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          left: 10,
          bottom: 10,
          right: 20,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withValues(alpha: .4),
                height: 65,
                width: 160,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(place['name'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                        Text(place['travel_info']['from_city'], style: TextStyle(fontSize: 12, color: Colors.white))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

