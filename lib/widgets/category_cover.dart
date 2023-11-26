import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hello_world/themes/theme.dart';

class CategoryCover extends StatelessWidget {
  final String pathOrUrl;
  const CategoryCover({super.key, required this.pathOrUrl});

  @override
  Widget build(BuildContext context) {
    final isCoverLocal = !pathOrUrl.contains('http');

    return SizedBox(
      height: 80,
      width: MediaQuery.of(context).size.width,
      child: isCoverLocal
          ? Image.asset(pathOrUrl, fit: BoxFit.cover)
          : CachedNetworkImage(
              imageUrl: pathOrUrl,
              fit: BoxFit.cover,
              placeholder: (BuildContext context, String str) {
                return Container(color: themeColors['disabled'])
                    .animate(
                      onPlay: (controller) => controller.repeat(),
                    )
                    .shimmer(duration: 1000.ms, delay: 1000.ms);
              }),
    );
  }
}
