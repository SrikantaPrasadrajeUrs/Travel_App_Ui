import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    return LayoutBuilder(
      builder: (context, boxConstraints) {
        final double maxHeight = boxConstraints.maxHeight.clamp(150, 400);
        return SizedBox(
          height: maxHeight,
          child: StreamBuilder(
            stream: fetchPlaces(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print("${snapshot.error}, ${snapshot.stackTrace}");
                return Image.network(
                  "https://img.freepik.com/premium-vector/error-404-flat-style-design-vector-illustration-stock-illustration_357500-2884.jpg",
                );
              }
              if (snapshot.hasData) {
                final List<Place> places = snapshot.data!;
                return ValueListenableBuilder(
                  valueListenable: highLightedIndex,
                  builder: (context, isHighlighted, _) {
                    return ListView.builder(
                      controller: scrollController,
                      itemCount: places.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final Place place = places[index];
                        return ImageView(
                          place: place,
                          requireBackButton: index != 0,
                          isHighLighted: isHighlighted == index,
                          requireSaveButton: false,
                          requireRating: false,
                          requirePrice: false,
                          requireFavoriteButton: false,
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
      },
    );
  }
}
