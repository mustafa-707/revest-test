import 'package:flutter/material.dart';
import 'package:revest/presentation/components/animated/circular_progress.dart';
import 'package:visibility_cached_image/visibility_cached_image.dart';

class ImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final bool disenableVisibility;
  final String? heroTag;
  static final calculateHeroOffset = 1152921504606846976 * 7;

  const ImageWidget({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.fit,
    this.disenableVisibility = false,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return VisibilityCachedImage(
      imageUrl: imageUrl,
      height: height,
      width: width,
      heroTag: heroTag == null ? null : heroTag! + calculateHeroOffset.toString(),
      cacheHeight: height?.toInt(),
      cacheWidth: width?.toInt(),
      fit: fit ?? BoxFit.cover,
      disableVisibility: disenableVisibility,
      loadingBuilder: (_, progress) => Center(
        child: SizedBox(
          height: 50,
          width: 50,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedCircularProgress(
                progress: progress,
              ),
              Icon(
                Icons.image,
                color: Colors.blueAccent.withValues(alpha: .2),
                size: 30,
              ),
            ],
          ),
        ),
      ),
      errorBuilder: (_, __, ___) => const Center(
        child: Icon(Icons.error, color: Colors.red),
      ),
    );
  }
}
