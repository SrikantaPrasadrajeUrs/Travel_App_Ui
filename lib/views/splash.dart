import 'package:flutter/material.dart';
import 'package:flutter_b3/views/home.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 2), (){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(52, 113, 175, 1),
                Color.fromRGBO(32, 70, 125, 1),
                Color.fromRGBO(12, 24, 72, 1)
              ]
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Travel", style: GoogleFonts.lobster(fontSize: 44, color: Colors.white)),
                SizedBox(width: 15),
                Image.asset("assets/images/globe icon.png")
              ],
            ),
            SizedBox(height: 25),
            Text("Find your dreams", style: textStyle,),
            Text("Destination with us", style: textStyle,)
          ],
        ),
      ),
    );
  }

  @override
  void dispose(){
    super.dispose();
  }
}
//
