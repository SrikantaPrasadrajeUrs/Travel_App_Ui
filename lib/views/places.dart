import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b3/widgets/place_view.dart';

class Places extends StatefulWidget {
  const Places({super.key});

  @override
  State<Places> createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  final placesCollection = FirebaseFirestore.instance.collection("places");
  late ScrollController scrollController;
  ValueNotifier<int> highLightedIndex = ValueNotifier<int>(0);
  final cardWidth = 220;
  late final double centerScreen;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(findCenterImage);
    super.initState();
  }

  Stream<List<dynamic>> fetchPlaces() {
    return placesCollection.snapshots().map(
      (event) => event.docs.map((ele) => ele.data()).toList(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    centerScreen = MediaQuery.of(context).size.width / 2;
  }

  // ui issue
  // computation

  void findCenterImage() {
    final centerPosition = scrollController.offset + centerScreen;
    double index = centerPosition / cardWidth;
    highLightedIndex.value = index.floor();
  }

  @override
  Widget build(BuildContext context) {
    fetchPlaces();
    return SizedBox(
      height: 350,
      child: StreamBuilder(
        stream: fetchPlaces(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> places = snapshot.data!;
            return ValueListenableBuilder(
              valueListenable: highLightedIndex,
              builder: (context, notifier, _) {
                return ListView.builder(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: places.length,
                  itemBuilder: (context, index) {
                    return AnimatedContainer(
                      margin: EdgeInsets.symmetric(vertical: 25),
                      duration: Duration(milliseconds: 400),
                      transform:
                          notifier == index
                              ? Matrix4.translationValues(0, -20, 0)
                              : Matrix4.translationValues(0, 0, 0),
                      padding: const EdgeInsets.all(8.0),
                      child: PlaceView(place: places[index]),
                    );
                  },
                );
              },
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
