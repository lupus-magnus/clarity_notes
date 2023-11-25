import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

// TODO: Extract API key to .env file
// ignore: constant_identifier_names
const String PEXELS_API_KEY =
    "DCM9cVMEg360YOdbjhSKiY4SJKiIcyBpW6nXGgvUrvLP0CuuJjwVSlKM";

String baseUrl = "https://api.pexels.com/v1/";

Future<dynamic> getSearchImagesAlpha(String search) async {
  String url = "$baseUrl/search?query=$search&orientation=landscape&per_page=5";
  final uri = Uri.parse(url);
  final response = await http.get(
    uri,
    headers: {
      HttpHeaders.authorizationHeader: PEXELS_API_KEY,
    },
  );

  final json = jsonDecode(response.body);
  final photoMaps = json['photos'] as List;
  final photos = photoMaps.map((e) => e['src']['original']).toList();

  return photos;
}
