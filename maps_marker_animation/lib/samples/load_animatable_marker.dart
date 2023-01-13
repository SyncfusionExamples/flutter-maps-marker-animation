import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class LoadAnimatableMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Load animatable marker')),
      body: Center(
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blue[900],
            side: BorderSide(color: Colors.blue[900]!),
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      _LoadAnimatableMarkerAtLoadtime()),
            );
          },
          child: Text('Load animatable marker'),
        ),
      ),
    );
  }
}

class _LoadAnimatableMarkerAtLoadtime extends StatefulWidget {
  @override
  _LoadAnimatableMarkerAtLoadtimeState createState() =>
      _LoadAnimatableMarkerAtLoadtimeState();
}

class _LoadAnimatableMarkerAtLoadtimeState
    extends State<_LoadAnimatableMarkerAtLoadtime>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _animation;
  late Map<String, MapLatLng> _markers;

  int _selectedMarkerIndex = 4;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 750));
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);

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
    _controller.repeat(min: 0.15, max: 1.0, reverse: true);
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
      appBar: AppBar(title: Text('Load animatable marker')),
      body: MapTileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        initialZoomLevel: 3,
        initialFocalLatLng: MapLatLng(2.3104, 16.5581),
        initialMarkersCount: _markers.length,
        markerBuilder: (BuildContext context, int index) {
          final double size = _selectedMarkerIndex == index ? 40 : 25;
          final MapLatLng markerData = _markers.values.elementAt(index);
          final Icon current = Icon(Icons.location_pin, size: size);
          return MapMarker(
            latitude: markerData.latitude,
            longitude: markerData.longitude,
            child: Transform.translate(
              offset: Offset(0.0, -size / 2),
              child: _selectedMarkerIndex == index
                  ? ScaleTransition(
                      alignment: Alignment.bottomCenter,
                      scale: _animation,
                      child: current)
                  : current,
            ),
          );
        },
      ),
    );
  }
}
