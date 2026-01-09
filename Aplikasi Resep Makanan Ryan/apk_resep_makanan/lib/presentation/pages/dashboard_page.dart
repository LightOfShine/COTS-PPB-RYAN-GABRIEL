import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/recipe_controller.dart';
import '../../design_system/colors.dart';
import '../../design_system/typography.dart';
import '../../design_system/spacing.dart';
import '../widgets/category_card.dart';
import '../widgets/recipe_card.dart';
import 'recipe_list_page.dart';
import 'recipe_detail_page.dart';
import 'add_recipe_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key}); // Added key parameter

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late RecipeController _controller;
  Map<String, int> _counts = {
    'Semua': 0,
    'Sarapan': 0,
    'Makan Siang': 0,
    'Makan Malam': 0,
    'Dessert': 0,
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    _controller = Provider.of<RecipeController>(context, listen: false);
    await _controller.fetchRecipes();
    _counts = await _controller.getRecipeCounts();
    setState(() {});
  }

  Color _withOpacity(Color color, double opacity) {
    return Color.fromRGBO(color.red, color.green, color.blue, opacity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resep Masakan', style: AppTypography.titleLarge),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Total Resep Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: _withOpacity(AppColors.primary, 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
                border: Border.all(color: _withOpacity(AppColors.primary, 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Resep',
                    style:
                        AppTypography.captionStyle, // Fixed: use captionStyle
                  ),
                  Text(
                    _counts['Semua'].toString(),
                    style: AppTypography.titleLarge.copyWith(
                      fontSize: 32,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Categories Section
            Text('Kategori', style: AppTypography.sectionTitle),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  CategoryCard(
                    title: 'Sarapan',
                    count: _counts['Sarapan'] ?? 0,
                    color: AppColors.breakfast,
                    onTap: () => _navigateToCategory('Sarapan'),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  CategoryCard(
                    title: 'Makan Siang',
                    count: _counts['Makan Siang'] ?? 0,
                    color: AppColors.lunch,
                    onTap: () => _navigateToCategory('Makan Siang'),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  CategoryCard(
                    title: 'Makan Malam',
                    count: _counts['Makan Malam'] ?? 0,
                    color: AppColors.dinner,
                    onTap: () => _navigateToCategory('Makan Malam'),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  CategoryCard(
                    title: 'Dessert',
                    count: _counts['Dessert'] ?? 0,
                    color: AppColors.dessert,
                    onTap: () => _navigateToCategory('Dessert'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Recent Recipes Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Resep Terbaru', style: AppTypography.sectionTitle),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RecipeListPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Lihat Semua',
                    style: AppTypography.body.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Consumer<RecipeController>(
              builder: (context, controller, child) {
                if (controller.isLoading && controller.recipes.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                final recentRecipes = controller.recipes.take(3).toList();
                if (recentRecipes.isEmpty) {
                  return Center(
                    child: Text(
                      'Belum ada resep',
                      style: AppTypography.body.copyWith(
                        color: AppColors.muted,
                      ),
                    ),
                  );
                }

                return Column(
                  children: recentRecipes.map((recipe) {
                    return RecipeCard(
                      title: recipe.title,
                      category: recipe.category,
                      duration: '30 Menit', // Default value
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RecipeDetailPage(recipeId: recipe.id!),
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddRecipePage()),
          );
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _navigateToCategory(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeListPage(initialCategory: category),
      ),
    );
  }
}
