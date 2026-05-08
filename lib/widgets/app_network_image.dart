import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const AppNetworkImage({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final child = Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, _, __) {
        return _Fallback(
          width: width,
          height: height,
        );
      },
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return _Loading(
          width: width,
          height: height,
        );
      },
    );

    if (borderRadius == null) return child;

    return ClipRRect(
      borderRadius: borderRadius!,
      child: child,
    );
  }
}

class _Loading extends StatelessWidget {
  final double? width;
  final double? height;

  const _Loading({
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.white10,
      child: const Center(
        child: SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }
}

class _Fallback extends StatelessWidget {
  final double? width;
  final double? height;

  const _Fallback({
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.white10,
      child: Icon(
        Icons.image_not_supported_outlined,
        color: Colors.grey.shade500,
      ),
    );
  }
}

