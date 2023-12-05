import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:hello_world/env.dart';
import 'package:http/http.dart' as http;

String baseUrl = "https://api.pexels.com/v1/";

Future<dynamic> getSearchImagesAlpha(
    String search, BuildContext context) async {
  String url = "$baseUrl/search?query=$search&orientation=landscape&per_page=3";
  final uri = Uri.parse(url);
  try {
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
  } catch (e) {
    // ignore: use_build_context_synchronously
    showToast(
      "Não foi possível realizar a operação agora.\nPor favor, tente mais tarde.",
      context: context,
    );
  }
}
