import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Places extends StatefulWidget {
  const Places({super.key});

  @override
  State<Places> createState() => _PlacesState();
}

class _PlacesState extends State<Places> {

  late final List<String> naturesImages;
  late ScrollController scrollController;
  ValueNotifier<int> highLightedIndex = ValueNotifier<int>(0);
  final cardWidth = 220;
  late final double centerScreen;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(findCenterImage);
    naturesImages = [
      "assets/images/nature1.jpeg",
      "assets/images/nature2.jpeg",
      "assets/images/nature3.jpeg",
      "assets/images/nature4.png"
    ];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    centerScreen = MediaQuery.of(context).size.width/2;
  }

  // ui issue
  // computation

  void findCenterImage(){
    final centerPosition = scrollController.offset+centerScreen;
    double index = centerPosition/cardWidth;
    highLightedIndex.value = index.floor();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: ValueListenableBuilder(
          valueListenable: highLightedIndex,
          builder: (context, notifier, _) {
          return ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: naturesImages.length,
              itemBuilder: (context, index){
                return AnimatedContainer(
                  margin: EdgeInsets.symmetric(vertical: 25),
                  duration: Duration(milliseconds: 400),
                  transform: notifier==index?Matrix4.translationValues(0, -20, 0):Matrix4.translationValues(0, 0, 0),
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(naturesImages[index], width: 200, height: 390, fit: BoxFit.fill),
                  ),
                );
          });
        }
      ),
    );
  }
}
