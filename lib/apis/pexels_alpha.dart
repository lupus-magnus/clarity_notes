import 'dart:convert';
import 'dart:io';

import 'package:hello_world/env.dart';
import 'package:http/http.dart' as http;

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
