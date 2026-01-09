import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/recipe_controller.dart';
import '../../design_system/colors.dart';
import '../../design_system/typography.dart';
import '../../design_system/spacing.dart';
import '../../models/recipe_model.dart';
import '../widgets/custom_button.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key}); // Fixed key parameter

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _stepsController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String _selectedCategory = 'Sarapan';
  final List<String> _categories = [
    'Sarapan',
    'Makan Siang',
    'Makan Malam',
    'Dessert',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _ingredientsController.dispose();
    _stepsController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final recipe = Recipe(
      title: _titleController.text.trim(),
      category: _selectedCategory,
      ingredients: _ingredientsController.text.trim(),
      steps: _stepsController.text.trim(),
      note: _noteController.text.trim(),
    );

    final controller = Provider.of<RecipeController>(context, listen: false);

    try {
      await controller.addRecipe(recipe);

      // Check if widget is still mounted
      if (!mounted) return;

      if (controller.error.isEmpty) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Resep berhasil ditambahkan!',
              style: AppTypography.body.copyWith(color: Colors.white),
            ),
            backgroundColor: AppColors.success,
            duration: const Duration(seconds: 2),
          ),
        );

        // Clear form
        _formKey.currentState!.reset();
        _titleController.clear();
        _ingredientsController.clear();
        _stepsController.clear();
        _noteController.clear();
        setState(() {
          _selectedCategory = 'Sarapan';
        });

        // Navigate back after short delay
        await Future.delayed(const Duration(seconds: 1));

        if (!mounted) return;
        Navigator.pop(context);
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              controller.error,
              style: AppTypography.body.copyWith(color: Colors.white),
            ),
            backgroundColor: AppColors.danger,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Terjadi kesalahan: $e',
            style: AppTypography.body.copyWith(color: Colors.white),
          ),
          backgroundColor: AppColors.danger,
        ),
      );
    }
  }

  Color _withOpacity(Color color, double opacity) {
    return Color.fromRGBO(color.red, color.green, color.blue, opacity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Resep Baru', style: AppTypography.titleLarge),
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Input
              Text('Judul Resep', style: AppTypography.sectionTitle),
              const SizedBox(height: AppSpacing.sm),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Contoh: Nasi Goreng Spesial',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppSpacing.borderRadius,
                    ),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Judul resep tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.lg),

              // Category Selection
              Text('Kategori', style: AppTypography.sectionTitle),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: _categories.map((category) {
                  final isSelected = _selectedCategory == category;
                  return ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    backgroundColor: isSelected
                        ? _withOpacity(AppColors.primary, 0.1)
                        : AppColors.background,
                    selectedColor: AppColors.primary,
                    labelStyle: AppTypography.body.copyWith(
                      color: isSelected ? Colors.white : AppColors.text,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Ingredients Input
              Text('Bahan-bahan', style: AppTypography.sectionTitle),
              const SizedBox(height: AppSpacing.sm),
              TextFormField(
                controller: _ingredientsController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText:
                      'Masukkan bahan-bahan resep\nContoh:\n- Nasi putih (2 piring)\n- Telur (2 butir)\n- Bawang merah (3 siung)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppSpacing.borderRadius,
                    ),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  contentPadding: const EdgeInsets.all(AppSpacing.md),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Bahan-bahan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.lg),

              // Steps Input
              Text('Langkah-langkah', style: AppTypography.sectionTitle),
              const SizedBox(height: AppSpacing.sm),
              TextFormField(
                controller: _stepsController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText:
                      'Masukkan langkah-langkah memasak\nContoh:\n1. Panaskan minyak\n2. Tumis bumbu\n3. Masukkan nasi dan bahan lain\n4. Masak hingga matang',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppSpacing.borderRadius,
                    ),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  contentPadding: const EdgeInsets.all(AppSpacing.md),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Langkah-langkah tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.lg),

              // Note Input
              Text('Catatan (Opsional)', style: AppTypography.sectionTitle),
              const SizedBox(height: AppSpacing.sm),
              TextFormField(
                controller: _noteController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText:
                      'Tambahkan catatan tambahan\nContoh: Tambahkan kerupuk untuk pelengkap',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppSpacing.borderRadius,
                    ),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  contentPadding: const EdgeInsets.all(AppSpacing.md),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Submit Button
              Consumer<RecipeController>(
                builder: (context, controller, child) {
                  return CustomButton(
                    text: 'Simpan Resep',
                    onPressed: _submitForm,
                    isLoading: controller.isLoading,
                  );
                },
              ),
              const SizedBox(height: AppSpacing.md),

              // Cancel Button
              SizedBox(
                width: double.infinity,
                height: AppSpacing.buttonHeight,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppSpacing.borderRadius,
                      ),
                    ),
                  ),
                  child: Text(
                    'Batal',
                    style: AppTypography.button.copyWith(color: AppColors.text),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
