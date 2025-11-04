import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text("Hi, David ", style: GoogleFonts.montserrat(fontSize: 30, fontWeight: FontWeight.w600)),
                          Container(
                              margin: EdgeInsets.only(bottom: 9),
                              child: Image.asset("assets/images/waving-hand.png", height: 40,))
                        ],
                      ),
                      Text("Explore the world", style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: .5, color: Color.fromRGBO(136, 136, 136, 1)),),
                    ],
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset("assets/images/person_image.png", height: 60,))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
