import 'package:flutter/material.dart';

class Places extends StatefulWidget {
  const Places({super.key});

  @override
  State<Places> createState() => _PlacesState();
}

class _PlacesState extends State<Places> {

  late final List<String> naturesImages;
  late ScrollController scrollController;
  ValueNotifier<int> highLightedIndex = ValueNotifier<int>(0);

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

  void findCenterImage(){
    final currentPosition =scrollController.offset;
    final maxScrollExtent = scrollController.position.maxScrollExtent;
    int index = (currentPosition/maxScrollExtent*4).round();
    highLightedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 350,
      child: ValueListenableBuilder(
          valueListenable: highLightedIndex,
          builder: (context, notifier, _) {
          return ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: naturesImages.length,
              itemBuilder: (context, index){
                return ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: AnimatedContainer(
                    duration: Duration(seconds: 2),
                    transform: notifier==index?Matrix4.translationValues(0, -20, 0):null,
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(naturesImages[index], width: 220, height: 390, fit: BoxFit.fill),
                  ),
                );
          });
        }
      ),
    );
  }
}
