import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ViewportOffset;
import 'carousel_flow_delegate.dart';
import 'filter_item.dart';

class FilterSelector extends StatefulWidget {
  const FilterSelector({
    super.key,
    required this.filters,
    required this.onFilterChanged,
    required this.onTakePicture,
  });

  final List<Color> filters;
  final ValueChanged<Color> onFilterChanged;
  final VoidCallback onTakePicture;

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
    return GestureDetector(
      onTap: widget.onTakePicture,
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