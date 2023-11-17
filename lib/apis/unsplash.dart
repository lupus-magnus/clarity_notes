import 'dart:convert';

import 'package:http/http.dart' as http;

// TODO: Colocar a chave da API em um .env
// ignore: constant_identifier_names
const String PEXELS_API_KEY =
    "DCM9cVMEg360YOdbjhSKiY4SJKiIcyBpW6nXGgvUrvLP0CuuJjwVSlKM";

String baseUrl = "https://api.pexels.com/v1/";

class TGetSearchImagesResponse {
  final int page;
  final List<dynamic> photos;
  final String photographer;
  final String photographerUrl;

  TGetSearchImagesResponse(
      {required this.page,
      required this.photos,
      required this.photographer,
      required this.photographerUrl});

  factory TGetSearchImagesResponse.fromJson(Map<String, dynamic> json) {
    return TGetSearchImagesResponse(
        page: json['page'],
        photos: (json['photos'] as List).map((e) => e['url']).toList(),
        photographer: json['photographer'],
        photographerUrl: json['photographer_url']);
  }
}

Future<TGetSearchImagesResponse> getSearchImages(String search) async {
  final response = await http.get(Uri.parse(
      "$baseUrl/search?query=$search&orientation=landscape&per_page=5"));

  if (response.statusCode == 200) {
    return TGetSearchImagesResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Pexels photos');
  }
}
