import 'package:flutter/material.dart';
import '../../design_system/colors.dart';
import '../../design_system/typography.dart';
import '../../design_system/spacing.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final int count;
  final Color color;
  final VoidCallback onTap;

  const CategoryCard({
    super.key, // Fixed key parameter
    required this.title,
    required this.count,
    required this.color,
    required this.onTap,
  });

  Color _withOpacity(Color color, double opacity) {
    return Color.fromRGBO(color.red, color.green, color.blue, opacity);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: _withOpacity(color, 0.1),
          borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
          border: Border.all(color: _withOpacity(color, 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTypography.sectionTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Text(
                  count.toString(),
                  style: AppTypography.titleLarge.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  'Resep',
                  style: AppTypography.captionStyle, // Fixed: use captionStyle
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
