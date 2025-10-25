import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';

class SRoundedImage extends StatelessWidget {
  const SRoundedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor,
    this.fit = BoxFit.contain,
    this.padding,
    this.isNetworkImage = false,
    this.onTap,
    this.borderRadius = SSizes.md,
  });

  final String imageUrl;
  final double? width, height;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onTap;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    Widget image = isNetworkImage
        ? CachedNetworkImage(imageUrl: imageUrl, errorWidget: (context, url, error) => const Icon(Icons.error),)
        : Image(image: AssetImage(imageUrl), fit: fit);

    Widget content = Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        border: border,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ClipRRect(
        borderRadius: applyImageRadius
            ? BorderRadius.circular(borderRadius)
            : BorderRadius.zero,
        child: image,
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: content,
      );
    }
    return content;
  }
}