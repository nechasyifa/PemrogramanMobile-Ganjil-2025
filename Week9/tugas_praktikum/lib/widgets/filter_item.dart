import 'package:flutter/material.dart';

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
            color: color == Colors.white ? null : color.withOpacity(0.5),
            colorBlendMode: color == Colors.white ? null : BlendMode.color,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}