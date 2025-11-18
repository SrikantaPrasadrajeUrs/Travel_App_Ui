import 'package:flutter/material.dart';
import 'package:flutter_b3/views/places.dart';
import 'package:flutter_b3/widgets/ui_btm_bar.dart';
import 'package:flutter_b3/widgets/ui_tab.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final fieldBorderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(color: Color.fromRGBO(210, 210, 210, 1), width: 2),
  );

  int highLightedTabIndex = 0;

  final tabTexts = ["Most Viewed","Nearby","Latest"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            spacing: 40,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              applyPadding(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Hi, David ",
                        style: GoogleFonts.montserrat(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 9),
                        child: Image.asset(
                          "assets/images/wave.png",
                          height: 35,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Explore the world",
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: .5,
                      color: Color.fromRGBO(136, 136, 136, 1),
                    ),
                  ),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  "assets/images/person_image.png",
                  height: 50,
                ),
              ),
            ],
          )),
              applyPadding(TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 25,
                  ),
                  hintText: "Search places",
                  hintStyle: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Color.fromRGBO(136, 136, 135, 1),
                  ),
                  enabledBorder: fieldBorderStyle,
                  focusedBorder: fieldBorderStyle,
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        color: Color.fromRGBO(210, 210, 210, 1),
                        width: 2,
                        height: 35,
                      ),
                      SizedBox(width: 20),
                      Image.asset("assets/images/icon setting.png"),
                      SizedBox(width: 15),
                    ],
                  ),
                ),
              )),
              applyPadding(Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular places",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "View all",
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(136, 136, 136, 1),
                    ),
                  ),
                ],
              )),
              applyPadding(StatefulBuilder(
                  builder: (context, innerSetState) {
                    void handleTap(int id) {
                      innerSetState(() {
                        highLightedTabIndex = id;
                      });
                    }
                    return Row(
                        spacing: 20,
                        children: List.generate(tabTexts.length,(index)=>Expanded(
                          child: UiTab(
                            text: tabTexts[index],
                            callback: () => handleTap(index),
                            isHighLighted: highLightedTabIndex == index,
                          ),
                        )).toList()
                    );
                  }
              )),
              Places()
            ],
          ),
        ),
      ),
      bottomNavigationBar: UiBtmBar(),
    );
  }

  Widget applyPadding(Widget child){
    return Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: child);
  }
}
