import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ViewportOffset;

class CarouselFlowDelegate extends FlowDelegate {
  CarouselFlowDelegate({
    required this.viewportOffset,
    required this.filtersPerScreen,
  }) : super(repaint: viewportOffset);

  final ViewportOffset viewportOffset;
  final int filtersPerScreen;

  @override
  void paintChildren(FlowPaintingContext context) {
    final count = context.childCount;
    final width = context.size.width;
    final height = context.size.height;
    final itemExtent = width / filtersPerScreen;

    for (var index = 0; index < count; index++) {
      final itemXFromCenter = itemExtent * index - viewportOffset.pixels;
      final percentFromCenter = 1.0 - (itemXFromCenter / (width / 2)).abs();
      final itemScale = 0.6 + (percentFromCenter * 0.4);
      final opacity = 0.25 + (percentFromCenter * 0.75);

      final yOffset = (height / 2) - (itemExtent / 2);

      final itemTransform = Matrix4.identity()
        ..translate(width / 2)
        ..translate(itemXFromCenter)
        ..translate(-itemExtent / 2, yOffset)
        ..translate(itemExtent / 2, itemExtent / 2)
        ..multiply(Matrix4.diagonal3Values(itemScale, itemScale, 1.0))
        ..translate(-itemExtent / 2, -itemExtent / 2);

      context.paintChild(
        index,
        transform: itemTransform,
        opacity: opacity,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CarouselFlowDelegate oldDelegate) {
    return oldDelegate.viewportOffset != viewportOffset;
  }
}