import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_b3/models/places.dart';

class Places extends StatefulWidget {
  const Places({super.key});

  @override
  State<Places> createState() => _PlacesState();
}

class _PlacesState extends State<Places> {

  final places = FirebaseFirestore.instance.collection("places");

  Stream<List<Place>> fetchPlaces(){
    return places.snapshots().map((event) {
      return event.docs.map((e) => Place.fromFirestore(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, boxConstraints) {
        final double maxHeight = boxConstraints.maxHeight.clamp(150, 370);
        final double maxWidth = boxConstraints.maxWidth.clamp(80, 250);
        return SizedBox(
          height: maxHeight,
          child: StreamBuilder(stream: fetchPlaces(), builder: (context, snapshot){
            if(snapshot.hasError){
              return Image.network("https://img.freepik.com/premium-vector/error-404-flat-style-design-vector-illustration-stock-illustration_357500-2884.jpg");
            }
            if(snapshot.hasData){
              final List<Place> places = snapshot.data!;
              return ListView.builder(
                itemCount: places.length,
                scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                final Place place = places[index];
                return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(place.images[0], width: maxWidth, fit: BoxFit.cover,));
              });
            }
            return CircularProgressIndicator();
          }),
        );
      }
    );
  }
}
