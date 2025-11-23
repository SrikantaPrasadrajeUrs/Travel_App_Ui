import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b3/constants.dart';
import 'package:flutter_b3/models/places.dart';
import 'package:flutter_b3/widgets/image_view.dart';

class Places extends StatefulWidget {
  const Places({super.key});

  @override
  State<Places> createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  final places = FirebaseFirestore.instance.collection("places");
  late ScrollController scrollController;
  final ValueNotifier<int> highLightedIndex = ValueNotifier<int>(0);
  Timer? throttleTimer;

  late final double centerScreen;
  final cardWidth = 200;
  final leftRightPadding = 10;

  Stream<List<Place>> fetchPlaces() {
    return places.snapshots().map((event) {
      return event.docs.map((e) => Place.fromJson(e.data())).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(throttleFunctionCall);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    centerScreen = MediaQuery.of(context).size.width / 2;
  }

  void throttleFunctionCall() {
    if (throttleTimer?.isActive ?? false) return;
    throttleTimer = Timer(Duration(milliseconds: 500), findCenterImage);
  }

  @override
  void dispose() {
    highLightedIndex.dispose();
    scrollController.dispose();
    super.dispose();
  }

  /// This method is used to identify center image
  void findCenterImage() {
    if (!scrollController.hasClients) return;

    final screenCenter =
        scrollController.offset + (MediaQuery.of(context).size.width / 2);

    final itemWidth = cardWidth + leftRightPadding;

    int index = (screenCenter / itemWidth).floor();

    index = index.clamp(0, 5 - 1);
    highLightedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 390,
      child: StreamBuilder(
        stream: fetchPlaces(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Image.network(Constants.errorImageUrl);
          }
          if (snapshot.hasData) {
            final List<Place> places = snapshot.data!;
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
                      child: ImageView(
                        place: places[index],
                        isHighLighted: notifier == index,
                        requireBackButton: false,
                        requireFavoriteButton: false,
                        requirePrice: false,
                        requireRating: false,
                        requireSaveButton: false,
                      ),
                    );
                  },
                );
              },
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
