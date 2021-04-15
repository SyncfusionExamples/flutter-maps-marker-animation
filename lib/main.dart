import 'package:flutter/material.dart';

import 'samples/animate_group_of_markers_dynamically.dart';
import 'samples/animate_a_marker_dynamically.dart';
import 'samples/add_a_marker_dynamically.dart';
import 'samples/interactive_marker.dart';
import 'samples/load_animatable_marker.dart';

Color color = Color.fromRGBO(32, 49, 82, 1);
Color strokeColor = Color.fromRGBO(72, 165, 200, 1);
double strokeWidth = 0.75;

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<TileDetails> _tiles;

  @override
  void initState() {
    _tiles = [
      TileDetails('Load animatable marker', LoadAnimatableMarker()),
      TileDetails('Add a marker dynamically', AddingMarkerDynamically()),
      TileDetails(
          'Animate a marker dynamically', AnimateSingleMarkerDynamically()),
      TileDetails('Animate group of markers dynamically',
          AnimateGroupOfMarkersDynamically()),
      TileDetails('Interactive marker', InteractiveMarker()),
    ];
    super.initState();
  }

  @override
  void dispose() {
    _tiles.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Syncfusion Flutter Maps with Markers')),
      body: ListView.builder(
        itemCount: _tiles.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('${_tiles[index].title}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return _tiles[index].page;
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class TileDetails {
  const TileDetails(this.title, this.page);

  final String title;
  final Widget page;
}
