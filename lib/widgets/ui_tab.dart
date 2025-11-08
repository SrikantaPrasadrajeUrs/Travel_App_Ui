import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UiTab extends StatelessWidget {
  final bool isHighLighted;
  final VoidCallback callback;
  final String text;
  const UiTab({super.key, required this.text, required this.callback, required this.isHighLighted});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: 46,
        decoration: BoxDecoration(
          color: isHighLighted?Colors.black:Colors.grey.shade50,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isHighLighted?[
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 10,
              spreadRadius: 2
            )
          ]:null
        ),
        child: Center(child: Text(text,style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, color: isHighLighted?Colors.white:Color.fromRGBO(197, 197, 197, 1)))),
      ),
    );
  }
}
