import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

class MapPage extends StatefulWidget {
  MapPage({Key key,this.lng,this.lat,this.projectName}) : super(key: key);
  String lat;
  String lng;
  String projectName;
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }


  Future<void> _addMarker() async {
    final Uint8List markerIcon = await getBytesFromAsset('assets/img/marker.png', 120);
    var markerIdVal = widget.projectName;
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
      markerId: markerId,
      icon: BitmapDescriptor.fromBytes(markerIcon),
      position: LatLng(
        double.parse(widget.lat),
        double.parse(widget.lng),
      ),
    );
    setState(() {
      markers[markerId] = marker;
    });
  }
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addMarker();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: Set<Marker>.of(markers.values),
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(double.parse(widget.lat), double.parse(widget.lng)),
          zoom: 1.99,
        ),
      ),
    );
  }
}
