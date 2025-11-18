import 'package:flutter/material.dart';
import 'package:flutter_b3/models/places.dart';

class ImageView extends StatefulWidget {
  final Place place;
  final double width;
  final double height;
  final bool isHighlighted;

  const ImageView({
    super.key,
    required this.place,
    required this.isHighlighted,
    required this.width,
    required this.height,
  });

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    final double shadowScale = 0.9;
    final double shadowOffset = widget.isHighlighted ? 18 : 12;
    return Container(
      height: widget.height,
      width: widget.width,
      margin: EdgeInsets.all(20),
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Container(
            transform: Matrix4.translationValues(0, shadowOffset/2, 0),
            width: widget.width * shadowScale,
            height: widget.height * shadowScale,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: widget.isHighlighted ? 0.4 : 0.25),
                  blurRadius: widget.isHighlighted ? 40 : 25,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
            transform: Matrix4.translationValues(
              10,
              widget.isHighlighted ? -10 : 0,
              0,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                widget.place.images[0],
                width: widget.isHighlighted?widget.width:widget.width*0.7,
                height: widget.height,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
