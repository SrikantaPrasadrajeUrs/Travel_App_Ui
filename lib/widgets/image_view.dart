import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/places.dart';

class ImageView extends StatefulWidget {
  final bool requireBackButton;
  final bool isHighLighted;
  final bool requireSaveButton;
  final bool requireRating;
  final bool requirePrice;
  final bool requireFavoriteButton;
  final Place place;

  const ImageView({
    super.key,
    required this.requireBackButton,
    required this.isHighLighted,
    required this.requireSaveButton,
    required this.requireRating,
    required this.requirePrice,
    required this.requireFavoriteButton,
    required this.place,
  });

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          key: ObjectKey(widget.place.images[0]),
          borderRadius: BorderRadius.circular(18),
          child: Image.network(
            widget.place.images[1],
            width: 200,
            height: 390,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          left: 10,
          right: 20,
          bottom: 10,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                padding: EdgeInsets.only(left:10, top: 5, bottom: 20),
                color: Colors.black.withValues(alpha: .3),
                height: 65,
                width: 170,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("Mount Fuji, ", style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.white)),
                        Text("Tokyo",style: GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 12, color: Colors.white))
                      ],
                    ),
                    Row(
                        children: [
                          Icon(Icons.location_on_outlined, color: Colors.white, size: 18,)
                        ]
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}