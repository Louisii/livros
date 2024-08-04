import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class FrostedGlassCard extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget child;

  const FrostedGlassCard({
    this.height,
    this.width,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(
          sigmaX: 30.0,
          sigmaY: 30.0,
        ),
        child: Container(
          height: height,
          width: width,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            border: Border.all(
              color: Colors.white,
              width: 0.1,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          ),
          child: child,
        ),
      ),
    );
  }
}
