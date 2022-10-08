import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import '../helpers/location_helpers.dart';
import '../screens/maps_screen.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String ImagePreviewUrl;

  Future<void> getCurrentUserLocation() async {
    final locationData = await Location().getLocation();

    final StaticMapImage = LocationHelper.generateLocationPreviewImaghe(
        latitude: locationData.latitude, longitude: locationData.longitude);
    setState(() {
      ImagePreviewUrl = StaticMapImage;
    });
  }

  Future<void> selectOnMap() async {
    final LatLng selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapsScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 180,
          width: double.infinity,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: ImagePreviewUrl == null
              ? Text(
                  'No location chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  ImagePreviewUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
              onPressed: getCurrentUserLocation,
              icon: Icon(Icons.location_on),
              label: Text('Curret Location'),
            ),
            TextButton.icon(
              onPressed: selectOnMap,
              icon: Icon(Icons.map),
              label: Text('Select on map'),
            ),
          ],
        )
      ],
    );
  }
}
