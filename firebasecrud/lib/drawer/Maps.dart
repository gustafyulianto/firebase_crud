import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(Maps());

class Maps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maps Google',
      home: MapPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final LatLng KebunRaya = LatLng(-6.597979999999973, 106.79972600000002);
  final LatLng Curug = LatLng(-7.806242000000023, 110.39749099999999);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("MAPS FORM",
              style: TextStyle(fontSize: 30, fontFamily: 'DancingScript')),
        ),
        body: ListView(
          children: <Widget>[
            MapsWidget(
              KebunRaya: KebunRaya,
              title: 'Kebun Raya Bogor',
            ),
            MapsWidget(
              KebunRaya: Curug,
              title: 'Kebun Binatang Gembiraloka',
            ),
          ],
        ));
  }
}

class MapsWidget extends StatelessWidget {
  const MapsWidget({Key key, @required this.KebunRaya, this.title})
      : super(key: key);

  final LatLng KebunRaya;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(width: 10.0),
            Center(
              child: SizedBox(
                width: 300.0,
                height: 300,
                child: GoogleMap(
                    initialCameraPosition:
                        CameraPosition(target: KebunRaya, zoom: 10.0),
                    markers: <Marker>[
                      Marker(
                          markerId: MarkerId(title),
                          position: KebunRaya,
                          infoWindow: InfoWindow(title: title))
                    ].toSet(),
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                      Factory<OneSequenceGestureRecognizer>(
                          () => ScaleGestureRecognizer()),
                    ].toSet()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
