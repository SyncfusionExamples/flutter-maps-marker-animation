import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class AnimateGroupOfMarkersDynamically extends StatefulWidget {
  @override
  _AnimateGroupOfMarkersDynamicallyState createState() =>
      _AnimateGroupOfMarkersDynamicallyState();
}

class _AnimateGroupOfMarkersDynamicallyState
    extends State<AnimateGroupOfMarkersDynamically>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _animation;
  late MapTileLayerController _tileLayerController;
  late Map<String, MapLatLng> _markers;

  List<int> _selectedMarkerIndices = [];

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 750),
        reverseDuration: const Duration(milliseconds: 750));
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _tileLayerController = MapTileLayerController();

    _markers = <String, MapLatLng>{
      'Chad': MapLatLng(15.454166, 18.732206),
      'Nigeria': MapLatLng(9.081999, 8.675277),
      'DRC': MapLatLng(-4.038333, 21.758663),
      'CAR': MapLatLng(6.600281, 20.480205),
      'Sudan': MapLatLng(12.862807, 30.217636),
      'Kenya': MapLatLng(0.0236, 37.9062),
      'Zambia': MapLatLng(-10.974129, 30.861397),
      'Egypt': MapLatLng(25.174109, 28.776359),
      'Algeria': MapLatLng(24.276672, 7.308186),
    };

    _controller.repeat(min: 0.1, max: 1.0, reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    _markers.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animate group of markers dynamically')),
      body: MapTileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        initialZoomLevel: 3,
        initialFocalLatLng: MapLatLng(2.3104, 16.5581),
        controller: _tileLayerController,
        initialMarkersCount: _markers.length,
        markerBuilder: (BuildContext context, int index) {
          final double size = _selectedMarkerIndices.contains(index) ? 40 : 25;
          final MapLatLng markerLatLng = _markers.values.elementAt(index);
          Widget current = Icon(Icons.location_pin, size: size);
          return MapMarker(
            latitude: markerLatLng.latitude,
            longitude: markerLatLng.longitude,
            child: Transform.translate(
              offset: Offset(0.0, -size / 2),
              child: _selectedMarkerIndices.contains(index)
                  ? ScaleTransition(
                      alignment: Alignment.bottomCenter,
                      scale: _animation,
                      child: current)
                  : current,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.animation),
        onPressed: () {
          _selectedMarkerIndices = [0, 2, 4];
          _tileLayerController.updateMarkers(_selectedMarkerIndices);
          _controller.repeat(min: 0.1, max: 1.0, reverse: true);
        },
      ),
    );
  }
}
