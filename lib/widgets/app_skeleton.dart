import 'package:flutter/material.dart';

class AppSkeleton extends StatefulWidget {
  final double? width;
  final double? height;
  final BorderRadius borderRadius;

  const AppSkeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
  });

  @override
  State<AppSkeleton> createState() => _AppSkeletonState();
}

class _AppSkeletonState extends State<AppSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = (widget.width == null || widget.width == double.infinity)
            ? constraints.maxWidth
            : widget.width!;
        final h = (widget.height == null || widget.height == double.infinity)
            ? constraints.maxHeight
            : widget.height!;

        return AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            final t = _controller.value;
            return ClipRRect(
              borderRadius: widget.borderRadius,
              child: CustomPaint(
                size: Size(w.isFinite ? w : 0, h.isFinite ? h : 0),
                painter: _SkeletonPainter(t: t),
              ),
            );
          },
        );
      },
    );
  }
}

class _SkeletonPainter extends CustomPainter {
  final double t;
  _SkeletonPainter({required this.t});

  @override
  void paint(Canvas canvas, Size size) {
    final base = Paint()..color = Colors.white10;
    canvas.drawRect(Offset.zero & size, base);

    final shimmer = Paint()
      ..shader = LinearGradient(
        begin: Alignment(-1.0 + 2.0 * t, 0),
        end: Alignment(1.0 + 2.0 * t, 0),
        colors: const [
          Colors.transparent,
          Colors.white12,
          Colors.transparent,
        ],
        stops: const [0.25, 0.5, 0.75],
      ).createShader(Offset.zero & size);

    canvas.drawRect(Offset.zero & size, shimmer);
  }

  @override
  bool shouldRepaint(covariant _SkeletonPainter oldDelegate) =>
      oldDelegate.t != t;
}

