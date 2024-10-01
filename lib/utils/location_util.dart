import 'dart:convert';
import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'google_api_key';

class locationUtil {
  static String generateLocationPreviewImage({
    required double latitude,
    required double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static String generateLocationUrl({
    required double latitude,
    required double longitude,
  }) {
    //return 'https://www.google.com/maps/@?$latitude,$longitude&markers=color:red%7Clabel:Meu%20Local|$latitude,$longitude';

    return 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude&markers=color:red%7Clabel:A%7C$latitude,$longitude&zoom=1';

    // return 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  }

  static Future<String> getAddresFrom(LatLng position) async {
    final url =
        'https://nominatim.openstreetmap.org/reverse?lat=${position.latitude}&lon=${position.longitude}&format=json';

    final Uri uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      // Acesse os campos específicos do endereço
      final address =
          data['display_name']; // Isso retorna o endereço completo como string

      print("ADDRESS RESPONSE: $address");
      return address; // Retorna o endereço como string
    } else {
      throw Exception('Falha ao carregar endereço: ${response.statusCode}');
    }
  }
}
