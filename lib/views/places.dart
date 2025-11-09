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
  final ValueNotifier<int> highlightedIndex = ValueNotifier<int>(0);
  late final ScrollController controller;

  Stream<List<Place>> fetchPlaces() {
    return places.snapshots().map((event) {
      return event.docs.map((e) => Place.fromFirestore(e)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    controller.addListener(imageHighLighter);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, boxConstraints) {
        final double maxHeight = boxConstraints.maxHeight.clamp(150, 400);
        final double maxWidth = boxConstraints.maxWidth.clamp(80, 250);
        return SizedBox(
          height: maxHeight,
          child: StreamBuilder(
            stream: fetchPlaces(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Image.network(
                  "https://img.freepik.com/premium-vector/error-404-flat-style-design-vector-illustration-stock-illustration_357500-2884.jpg",
                );
              }
              if (snapshot.hasData) {
                final List<Place> places = snapshot.data!;
                return ValueListenableBuilder(
                  valueListenable: highlightedIndex,
                  builder: (context, isHighlighted, _) {
                    return ListView.builder(
                      controller: controller,
                      itemCount: places.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final Place place = places[index];
                        return ImageView(
                          place: place,
                          isHighlighted: isHighlighted == index,
                          width: maxWidth,
                          height: 170,
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

  void imageHighLighter() {
    final offset = controller.offset;
    final maxScrollExtent = controller.position.maxScrollExtent;
    if (maxScrollExtent == 0) {
      highlightedIndex.value = 0;
      return;
    }
    if(maxScrollExtent==offset){
      highlightedIndex.value = 4;
      return;
    }
    highlightedIndex.value = (offset / maxScrollExtent * 5).round();
  }
}
