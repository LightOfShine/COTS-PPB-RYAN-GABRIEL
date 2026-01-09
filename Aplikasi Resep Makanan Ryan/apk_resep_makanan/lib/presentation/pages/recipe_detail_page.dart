import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/recipe_controller.dart';
import '../../design_system/colors.dart';
import '../../design_system/typography.dart';
import '../../design_system/spacing.dart';
import '../../models/recipe_model.dart';

class RecipeDetailPage extends StatefulWidget {
  final int recipeId;

  const RecipeDetailPage({
    super.key,
    required this.recipeId,
  }); // Fixed key parameter

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  late Recipe? _recipe;
  bool _isEditingNote = false;
  final TextEditingController _noteController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadRecipe();
    });
  }

  void _loadRecipe() {
    final controller = Provider.of<RecipeController>(context, listen: false);
    _recipe = controller.getRecipeById(widget.recipeId);
    if (_recipe != null) {
      _noteController.text = _recipe!.note;
    }
    setState(() {});
  }

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

  Future<void> _updateNote() async {
    if (_formKey.currentState!.validate() && _recipe != null) {
      final controller = Provider.of<RecipeController>(context, listen: false);
      await controller.updateRecipeNote(_recipe!.id!, _noteController.text);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Catatan berhasil diperbarui'),
          backgroundColor: AppColors.success,
        ),
      );

      setState(() {
        _isEditingNote = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_recipe == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Resep')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Resep', style: AppTypography.titleLarge),
        backgroundColor: AppColors.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              setState(() {
                _isEditingNote = true;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Title
            Text(
              _recipe!.title,
              style: AppTypography.titleLarge.copyWith(fontSize: 24),
            ),
            const SizedBox(height: AppSpacing.sm),

            // Category Badge
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: _withOpacity(_getCategoryColor(_recipe!.category), 0.2),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: _getCategoryColor(_recipe!.category),
                  width: 1,
                ),
              ),
              child: Text(
                _recipe!.category,
                style: AppTypography.captionStyle.copyWith(
                  // Fixed: use captionStyle
                  color: AppColors.text,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Ingredients Section
            Text('Bahan-bahan', style: AppTypography.sectionTitle),
            const SizedBox(height: AppSpacing.sm),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
              ),
              child: Text(_recipe!.ingredients, style: AppTypography.body),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Steps Section
            Text('Langkah-langkah', style: AppTypography.sectionTitle),
            const SizedBox(height: AppSpacing.sm),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppSpacing.borderRadius),
              ),
              child: Text(_recipe!.steps, style: AppTypography.body),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Note Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Catatan', style: AppTypography.sectionTitle),
                if (_isEditingNote)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isEditingNote = false;
                      });
                    },
                    child: Text(
                      'Batal',
                      style: AppTypography.body.copyWith(
                        color: AppColors.danger,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            _isEditingNote
                ? Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _noteController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: 'Tambahkan catatan...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                AppSpacing.borderRadius,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Catatan tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppSpacing.md),
                        SizedBox(
                          width: double.infinity,
                          height: AppSpacing.buttonHeight,
                          child: ElevatedButton(
                            onPressed: _updateNote,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppSpacing.borderRadius,
                                ),
                              ),
                            ),
                            child: Text('Simpan', style: AppTypography.button),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(
                        AppSpacing.borderRadius,
                      ),
                    ),
                    child: Text(_recipe!.note, style: AppTypography.body),
                  ),
          ],
        ),
      ),
    );
  }
}
