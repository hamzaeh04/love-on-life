import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double size;
  final String placeholder;
  final double? width;
  final bool? isCommunity;

  const ProfileNetworkImage({
    super.key,
    required this.imageUrl,
    required this.size,
    required this.placeholder,
    this.isCommunity,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final Widget imageWidget = imageUrl.isEmpty
        ? _placeholder()
        : CachedNetworkImage(
      // ✅ Key ensures widget identity across rebuilds
      key: ValueKey(imageUrl),

      // ✅ Cached URL
      imageUrl: imageUrl,
      width: width ?? size,
      height: size,
      fit: isCommunity == true ? BoxFit.cover : BoxFit.cover,

      // ✅ Shimmer loading
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: width ?? size,
          height: size,
          color: Colors.white,
        ),
      ),

      // ✅ Placeholder on error
      errorWidget: (context, url, error) => _placeholder(),

      // ✅ Optional: prevent flicker / memory waste
      fadeInDuration: Duration.zero,
      fadeOutDuration: Duration.zero,
      memCacheWidth: 1200,
      memCacheHeight: 1200,
    );

    // ✅ Apply shape: Circle for non-community, rounded rect for community
    return ClipOval(child: imageWidget);
  }

  /// 🔹 Placeholder asset
  Widget _placeholder() {
    return Image.asset(
      placeholder,
      width: width ?? size,
      height: size,
      fit: BoxFit.cover,
    );
  }
}


class ProfileNetworkImage2 extends StatelessWidget {
  final String imageUrl;
  final double size;
  final String placeholder;
  final double? width;
  final bool? isCommunity;

  const ProfileNetworkImage2({
    super.key,
    required this.imageUrl,
    required this.size,
    required this.placeholder,
    this.isCommunity,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return isCommunity == false ?  ClipOval(
      child: imageUrl.isEmpty
          ? _placeholder()
          : Image.network(
        imageUrl,
        width: size,
        height: size,
        fit: BoxFit.contain,

        // ✅ Shimmer while loading
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;

          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: size,
              height: size,
              color: Colors.white,
            ),
          );
        },

        // ✅ Placeholder if error
        errorBuilder: (context, error, stackTrace) {
          return _placeholder();
        },
      ),
    ): ClipRRect(
      child: imageUrl.isEmpty
          ? _placeholder()
          : Image.network(
        imageUrl,
        width: width,
        height: size,
        fit: BoxFit.cover,

        // ✅ Shimmer while loading
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;

          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: size,
              height: size,
              color: Colors.white,
            ),
          );
        },

        // ✅ Placeholder if error
        errorBuilder: (context, error, stackTrace) {
          return _placeholder();
        },
      ),
    );
  }



  Widget _placeholder() {
    return Image.asset(
      placeholder,
      width: size,
      height: size,
      fit: BoxFit.cover,
    );
  }
}
