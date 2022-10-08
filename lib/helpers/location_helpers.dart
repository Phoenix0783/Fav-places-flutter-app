import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';

class LocationHelper {
  static String generateLocationPreviewImaghe(
      {double latitude, double longitude}) {
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/$longitude,$latitude,14.25,0,60/600x600?access_token=pk.eyJ1IjoicGhvZW5peC0wNzMiLCJhIjoiY2w3ZnN4YThrMGFlNDN1bzB0Ynl1dW80ayJ9.gDqDAsKlvOuUOgUDvV9-Fg';
  }
}

Future<String> getPlacesAdress(double lat, double lng) async {
  final url = await placemarkFromCoordinates(lat, lng);
  final response = await http.get(url);
}
