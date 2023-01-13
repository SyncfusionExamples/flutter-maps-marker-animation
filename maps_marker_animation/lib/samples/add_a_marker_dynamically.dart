import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class AddingMarkerDynamically extends StatefulWidget {
  @override
  _AddingMarkerDynamicallyState createState() =>
      _AddingMarkerDynamicallyState();
}

class _AddingMarkerDynamicallyState extends State<AddingMarkerDynamically>
    with SingleTickerProviderStateMixin {
  late MapTileLayerController _tileLayerController;

  @override
  void initState() {
    _tileLayerController = MapTileLayerController();
    super.initState();
  }

  @override
  void dispose() {
    _tileLayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add a marker dynamically')),
      body: MapTileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        initialZoomLevel: 3,
        initialFocalLatLng: MapLatLng(2.3104, 16.5581),
        controller: _tileLayerController,
        markerBuilder: (BuildContext context, int index) {
          return MapMarker(
            latitude: 6.6111,
            longitude: 20.9394,
            child: Transform.translate(
              offset: Offset(0.0, -20.0),
              child: Icon(Icons.location_pin, size: 40),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_location),
        onPressed: () => _tileLayerController.insertMarker(0),
      ),
    );
  }
}
