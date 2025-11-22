import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_b3/models/place.dart';
import 'package:flutter_b3/widgets/image_view.dart';

class Places extends StatefulWidget {
  const Places({super.key});

  @override
  State<Places> createState() => _PlacesState();
}

class _PlacesState extends State<Places> {

  late final List<String> naturesImages;
  late ScrollController scrollController;
  final ValueNotifier<int> highLightedIndex = ValueNotifier<int>(0);
  Timer? throttleTimer;

  late final double centerScreen;
  final cardWidth = 200;
  final leftRightPadding = 10;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(throttleFunctionCall);
    naturesImages = [
      "assets/images/nature1.jpeg",
      "assets/images/nature2.jpeg",
      "assets/images/nature3.jpeg",
      "assets/images/nature4.png",
    ];
    super.initState();
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

    index = index.clamp(0, naturesImages.length - 1);
    highLightedIndex.value = index;
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
                  place: Place.fromJson(),
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
      ),
    );
  }
}
