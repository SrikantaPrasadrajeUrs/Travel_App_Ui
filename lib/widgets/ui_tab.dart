import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tab extends StatelessWidget {
  final bool isHighLighted;
  final VoidCallback callback;
  final String text;
  const Tab({super.key, required this.text, required this.callback, required this.isHighLighted});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        height: 54,
        decoration: BoxDecoration(
          color: isHighLighted?Colors.black:Colors.grey.shade50,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(child: Text(text,style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500, color: isHighLighted?Colors.white:Color.fromRGBO(197, 197, 197, 1)))),
      ),
    );
  }
}
