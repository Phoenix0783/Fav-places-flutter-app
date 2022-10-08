import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/place.dart';

class MapsScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  const MapsScreen({
    this.initialLocation =
        const PlaceLocation(latitude: 37.422, longitude: -122.084),
    this.isSelecting = false,
  });

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  LatLng _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your map'),
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
              icon: Icon(Icons.check),
            ),
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          // onTap: widget.isSelecting ? _selectLocation : {},
          center: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 9.2,
        ),
        layers: [
          MarkerLayerOptions(
              markers: _pickedLocation == null
                  ? {}
                  : [
                      Marker(
                        point: _pickedLocation,
                        width: 80,
                        height: 80,
                        builder: (context) => FlutterLogo(),
                      ),
                    ]),
          TileLayerOptions(
              urlTemplate:
                  "https://api.mapbox.com/styles/v1/phoenix-073/cl7fuu0j2000l15r0q67hxenu/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicGhvZW5peC0wNzMiLCJhIjoiY2w3ZnN4YThrMGFlNDN1bzB0Ynl1dW80ayJ9.gDqDAsKlvOuUOgUDvV9-Fg",
              userAgentPackageName: 'com.example.app',
              additionalOptions: {
                'accessToken':
                    'pk.eyJ1IjoicGhvZW5peC0wNzMiLCJhIjoiY2w3ZnN4YThrMGFlNDN1bzB0Ynl1dW80ayJ9.gDqDAsKlvOuUOgUDvV9-Fg',
                'id': 'mapbox.mapbox-streets-v8'
              }),
        ],
        nonRotatedChildren: [
          AttributionWidget.defaultWidget(
            source: 'OpenStreetMap contributors',
            onSourceTapped: null,
          ),
        ],
      ),
    );
  }
}
