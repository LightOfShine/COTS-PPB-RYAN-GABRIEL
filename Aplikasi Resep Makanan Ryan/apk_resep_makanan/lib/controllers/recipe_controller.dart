import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../services/api_service.dart';

class RecipeController extends ChangeNotifier {
  final ApiService _apiService;
  List<Recipe> _recipes = [];
  bool _isLoading = false;
  String _error = '';

  RecipeController(this._apiService);

  List<Recipe> get recipes => _recipes;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchRecipes({String? category}) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _recipes = await _apiService.getRecipes(category: category);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addRecipe(Recipe recipe) async {
    _isLoading = true;
    notifyListeners();

    try {
      final newRecipe = await _apiService.addRecipe(recipe);
      _recipes.add(newRecipe);
      _error = '';
    } catch (e) {
      _error = 'Gagal menambah resep: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateRecipeNote(int id, String note) async {
    try {
      await _apiService.updateRecipeNote(id, note);
      final index = _recipes.indexWhere((r) => r.id == id);
      if (index != -1) {
        _recipes[index] = _recipes[index].copyWith(note: note);
        notifyListeners();
      }
    } catch (e) {
      _error = 'Gagal mengupdate resep: $e';
      notifyListeners();
    }
  }

  Future<Map<String, int>> getRecipeCounts() async {
    return await _apiService.getRecipeCounts();
  }

  Recipe? getRecipeById(int id) {
    return _recipes.firstWhere((recipe) => recipe.id == id);
  }

  void clearError() {
    _error = '';
    notifyListeners();
  }
}