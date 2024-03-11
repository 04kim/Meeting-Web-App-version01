import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    bool isScreenMinimized,
    double containerWidth,
    double logoSize,
    double maxLogoSize,
  ) builder;

  const ResponsiveLayout({required this.builder});

  @override
  Widget build(BuildContext context) {
    final bool isScreenMinimized = MediaQuery.of(context).size.width < 800;
    final double containerWidth =
        isScreenMinimized ? MediaQuery.of(context).size.width * 0.9 : 500;
    final double logoSize = isScreenMinimized ? 150 : 200;
    final double maxLogoSize = 500;

    return builder(
        context, isScreenMinimized, containerWidth, logoSize, maxLogoSize);
  }
}
