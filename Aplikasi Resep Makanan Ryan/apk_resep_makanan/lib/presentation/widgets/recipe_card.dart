import 'package:flutter/material.dart';
import '../../design_system/colors.dart';
import '../../design_system/typography.dart';
import '../../design_system/spacing.dart';

class RecipeCard extends StatelessWidget {
  final String title;
  final String category;
  final String duration;
  final VoidCallback onTap;

  const RecipeCard({
    super.key, // Fixed key parameter
    required this.title,
    required this.category,
    required this.duration,
    required this.onTap,
  });

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Sarapan':
        return AppColors.breakfast;
      case 'Makan Siang':
        return AppColors.lunch;
      case 'Makan Malam':
        return AppColors.dinner;
      case 'Dessert':
        return AppColors.dessert;
      default:
        return AppColors.primary;
    }
  }

  Color _withOpacity(Color color, double opacity) {
    return Color.fromRGBO(color.red, color.green, color.blue, opacity);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.md),
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(0, 0, 0, 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 4,
              height: 60,
              decoration: BoxDecoration(
                color: _getCategoryColor(category),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _withOpacity(_getCategoryColor(category), 0.2),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: _getCategoryColor(category),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          category,
                          style: AppTypography.captionStyle.copyWith(
                            // Fixed: use captionStyle
                            color: AppColors.text,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        duration,
                        style: AppTypography
                            .captionStyle, // Fixed: use captionStyle
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
