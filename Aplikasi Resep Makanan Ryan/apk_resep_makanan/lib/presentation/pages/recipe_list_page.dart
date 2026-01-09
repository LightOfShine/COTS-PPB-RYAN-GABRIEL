import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/recipe_controller.dart';
import '../../design_system/colors.dart';
import '../../design_system/typography.dart';
import '../../design_system/spacing.dart';
import '../widgets/recipe_card.dart';
import 'recipe_detail_page.dart';
import 'add_recipe_page.dart';

class RecipeListPage extends StatefulWidget {
  final String? initialCategory;

  const RecipeListPage({
    super.key,
    this.initialCategory,
  }); // Fixed key parameter

  @override
  State<RecipeListPage> createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  String? _selectedCategory;
  late RecipeController _controller;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller = Provider.of<RecipeController>(context, listen: false);
      _loadRecipes();
    });
  }

  Future<void> _loadRecipes() async {
    await _controller.fetchRecipes(category: _selectedCategory);
  }

  Color _withOpacity(Color color, double opacity) {
    return Color.fromRGBO(color.red, color.green, color.blue, opacity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Resep', style: AppTypography.titleLarge),
        backgroundColor: AppColors.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddRecipePage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            color: AppColors.background,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryChip('Semua'),
                  const SizedBox(width: AppSpacing.sm),
                  _buildCategoryChip('Sarapan'),
                  const SizedBox(width: AppSpacing.sm),
                  _buildCategoryChip('Makan Siang'),
                  const SizedBox(width: AppSpacing.sm),
                  _buildCategoryChip('Makan Malam'),
                  const SizedBox(width: AppSpacing.sm),
                  _buildCategoryChip('Dessert'),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Recipe List
          Expanded(
            child: Consumer<RecipeController>(
              builder: (context, controller, child) {
                if (controller.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.error.isNotEmpty) {
                  return Center(
                    child: Text(
                      controller.error,
                      style: AppTypography.body.copyWith(
                        color: AppColors.danger,
                      ),
                    ),
                  );
                }

                if (controller.recipes.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.menu_book,
                          size: 64,
                          color: _withOpacity(AppColors.muted, 0.5),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'Belum ada resep',
                          style: AppTypography.body.copyWith(
                            color: AppColors.muted,
                          ),
                        ),
                        if (_selectedCategory != null)
                          Text(
                            'Kategori: $_selectedCategory',
                            style: AppTypography
                                .captionStyle, // Fixed: use captionStyle
                          ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: _loadRecipes,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    itemCount: controller.recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = controller.recipes[index];
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
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    final isSelected = _selectedCategory == category;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = isSelected ? null : category;
        });
        _loadRecipes();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Text(
          category,
          style: AppTypography.captionStyle.copyWith(
            // Fixed: use captionStyle
            color: isSelected ? Colors.white : AppColors.text,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
