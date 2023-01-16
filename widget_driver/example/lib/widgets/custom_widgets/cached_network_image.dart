import 'package:cached_network_image/cached_network_image.dart' as pub_dev;
import 'package:flutter/material.dart';

class CachedNetworkImage extends StatelessWidget {
  final String imageUrl;

  const CachedNetworkImage({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return pub_dev.CachedNetworkImage(
      imageUrl: imageUrl,
      progressIndicatorBuilder: (context, url, downloadProgress) {
        return Center(
          child: SizedBox(
            width: 60.0,
            height: 60.0,
            child: CircularProgressIndicator(
                strokeWidth: 6, value: downloadProgress.progress),
          ),
        );
      },
      errorWidget: (context, url, error) => const Icon(Icons.error),
      height: 300,
      fit: BoxFit.fill,
    );
  }
}
