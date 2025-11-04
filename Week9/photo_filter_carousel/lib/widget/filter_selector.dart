import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ViewportOffset;

class FilterSelector extends StatefulWidget {
  const FilterSelector({
    super.key,
    required this.filters,
    required this.onFilterChanged,
  });

  final List<Color> filters;
  final ValueChanged<Color> onFilterChanged;

  @override
  State<FilterSelector> createState() => _FilterSelectorState();
}

class _FilterSelectorState extends State<FilterSelector> {
  static const _filtersPerScreen = 5;
  static const _viewportFractionPerItem = 1.0 / _filtersPerScreen;

  late final PageController _controller;
  late int _page;

  int get filterCount => widget.filters.length;
  Color itemColor(int index) => widget.filters[index % filterCount];

  @override
  void initState() {
    super.initState();
    _page = 0;
    _controller = PageController(
      viewportFraction: _viewportFractionPerItem,
    );
    _controller.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    final page = (_controller.page ?? 0).round();
    if (page != _page) {
      _page = page;
      widget.onFilterChanged(widget.filters[page]);
    }
  }

  void _onFilterTapped(int index) {
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollable(
      controller: _controller,
      axisDirection: AxisDirection.right,
      physics: const PageScrollPhysics(),
      viewportBuilder: (context, viewportOffset) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final itemSize = constraints.maxWidth * _viewportFractionPerItem;
            viewportOffset
              ..applyViewportDimension(constraints.maxWidth)
              ..applyContentDimensions(0.0, itemSize * (filterCount - 1));

            return Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                _buildCarousel(
                  viewportOffset: viewportOffset,
                  itemSize: itemSize,
                ),
                _buildSelectionRing(itemSize),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildCarousel({
    required ViewportOffset viewportOffset,
    required double itemSize,
  }) {
    return Flow(
      delegate: CarouselFlowDelegate(
        viewportOffset: viewportOffset,
        filtersPerScreen: _filtersPerScreen,
      ),
      children: [
        for (int i = 0; i < filterCount; i++)
          FilterItem(
            onFilterSelected: () => _onFilterTapped(i),
            color: itemColor(i),
            size: itemSize,
          ),
      ],
    );
  }

  Widget _buildSelectionRing(double itemSize) {
    return IgnorePointer(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: itemSize * 0.9,
        height: itemSize * 0.9,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 4,
            color: Colors.white.withOpacity(0.9),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
      ),
    );
  }
}

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

class FilterItem extends StatelessWidget {
  const FilterItem({
    super.key,
    required this.color,
    required this.onFilterSelected,
    required this.size,
  });

  final Color color;
  final VoidCallback onFilterSelected;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onFilterSelected,
      child: Container(
        width: size,
        height: size,
        padding: const EdgeInsets.all(10),
        child: ClipOval(
          child: Image.network(
            'https://images.unsplash.com/photo-1519681393784-d120267933ba?w=800',
            color: color.withOpacity(0.5),
            colorBlendMode: BlendMode.color,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}