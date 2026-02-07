import 'package:flutter/material.dart';
import '../models/category_tile.dart';
import '../theme.dart';

class CategoryScroller extends StatelessWidget {
  final List<CategoryTile> categories;
  final double tileHeight;

  const CategoryScroller({
    super.key,
    required this.categories,
    this.tileHeight = 100,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: tileHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final cat = categories[index];
          return _CategoryTileWidget(category: cat, height: tileHeight);
        },
      ),
    );
  }
}

class _CategoryTileWidget extends StatelessWidget {
  final CategoryTile category;
  final double height;

  const _CategoryTileWidget({required this.category, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: height * 1.2,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.greyBorder),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(category.icon, size: 30, color: Colors.black87),
          const SizedBox(height: 8),
          Text(
            category.label,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
