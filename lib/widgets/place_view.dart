import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
              return Image.asset("assets/images/nature3.jpeg",width: 210,
                height: 390,
                fit: BoxFit.fill);
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
                padding: EdgeInsets.all(8),
                color: Colors.black.withValues(alpha: .4),
                height: 65,
                width: 160,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                            constraints: BoxConstraints(
                              minWidth: 50,
                              maxWidth: 100
                            ),
                            child: Text(place['name']+",", overflow: TextOverflow.ellipsis, style: GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white))),
                        SizedBox(width: 5,),
                        SizedBox(
                            width: 40,
                            child: Text(place['travel_info']['from_city'], overflow: TextOverflow.ellipsis, style: GoogleFonts.roboto(fontSize: 11, fontWeight: FontWeight.w400, color: Colors.white)))
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset("assets/images/fi-rr-marker.png", width: 15, height: 15),
                        SizedBox(width: 12),
                        ConstrainedBox(
                            constraints: BoxConstraints(
                                minWidth: 50,
                                maxWidth: 100
                            ),
                            child: Text(place['travel_info']['from_city']+","+place['country'], overflow: TextOverflow.ellipsis, style: GoogleFonts.roboto(fontSize: 11, fontWeight: FontWeight.w400, color: Colors.white)))
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

