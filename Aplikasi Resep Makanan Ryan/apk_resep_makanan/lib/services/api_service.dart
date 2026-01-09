import 'dart:convert';
import 'dart:developer' show log;
import 'package:http/http.dart' as http;
import '../models/recipe_model.dart';
import '../config/constants.dart';

class ApiService {
  final String baseUrl = Constants.supabaseUrl;
  final String apiKey = Constants.supabaseAnonKey;

  Future<List<Recipe>> getRecipes({String? category}) async {
    try {
      String url = '$baseUrl/rest/v1/recipes?select=*';
      if (category != null && category != 'Semua') {
        url += '&category=eq.$category';
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {'apikey': apiKey, 'Authorization': 'Bearer $apiKey'},
      );

      // Debug logs
      log('GET $url');
      log(
        'Headers: {apikey: ${apiKey.substring(0, 10)}..., Authorization: Bearer ****}',
      );
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Recipe.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load recipes');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Recipe> addRecipe(Recipe recipe) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/rest/v1/recipes'),
        headers: {
          'apikey': apiKey,
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
          'Prefer': 'return=representation',
        },
        body: json.encode(recipe.toJson()),
      );

      // Debug logs
      log('POST $baseUrl/rest/v1/recipes');
      log('Request body: ${json.encode(recipe.toJson())}');
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        if (response.body.trim().isEmpty) {
          throw Exception('Empty response body from server');
        }
        final data = json.decode(response.body);
        if (data is List && data.isNotEmpty) {
          return Recipe.fromJson(data[0]);
        }
        throw Exception('Unexpected response format: ${response.body}');
      } else {
        throw Exception(
          'Failed to add recipe (status: ${response.statusCode}): ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> updateRecipeNote(int id, String note) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/rest/v1/recipes?id=eq.$id'),
        headers: {
          'apikey': apiKey,
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
          'Prefer': 'return=representation',
        },
        body: json.encode({'note': note}),
      );

      // Debug logs
      log('PATCH $baseUrl/rest/v1/recipes?id=eq.$id');
      log('Request body: ${json.encode({'note': note})}');
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Failed to update recipe');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, int>> getRecipeCounts() async {
    final recipes = await getRecipes();

    return {
      'Semua': recipes.length,
      'Sarapan': recipes.where((r) => r.category == 'Sarapan').length,
      'Makan Siang': recipes.where((r) => r.category == 'Makan Siang').length,
      'Makan Malam': recipes.where((r) => r.category == 'Makan Malam').length,
      'Dessert': recipes.where((r) => r.category == 'Dessert').length,
    };
  }
}
