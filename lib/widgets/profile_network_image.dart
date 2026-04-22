import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final String placeholder;
  final double? width;
  final bool isCommunity;

  const ProfileNetworkImage({
    super.key,
    required this.imageUrl,
    required this.size,
    required this.placeholder,
    this.width,
    this.isCommunity = false,
  });

  @override
  Widget build(BuildContext context) {
    final double finalWidth = width ?? size;

    Widget imageWidget;

    if (imageUrl == null || imageUrl!.isEmpty) {
      imageWidget = _placeholder(finalWidth);
    } else {
      imageWidget = CachedNetworkImage(
        key: ValueKey(imageUrl),
        imageUrl: imageUrl!,
        width: finalWidth,
        height: size,
        fit: BoxFit.cover,

        placeholder: (context, url) => _shimmer(finalWidth),

        errorWidget: (context, url, error) => _placeholder(finalWidth),

        fadeInDuration: Duration.zero,
        fadeOutDuration: Duration.zero,
        memCacheWidth: 1200,
        memCacheHeight: 1200,
      );
    }

    // ✅ Shape handling
    return isCommunity
        ? ClipRRect(
      borderRadius: BorderRadius.circular(12), // adjust as needed
      child: imageWidget,
    )
        : ClipOval(child: imageWidget);
  }

  Widget _shimmer(double width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: size,
        color: Colors.white,
      ),
    );
  }

  Widget _placeholder(double width) {
    return Image.asset(
      placeholder,
      width: width,
      height: size,
      fit: BoxFit.cover,
    );
  }
}