import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/pages/dashboard_page.dart';
import 'presentation/pages/recipe_list_page.dart';
import 'presentation/pages/add_recipe_page.dart';
import 'controllers/recipe_controller.dart';
import 'services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RecipeController(ApiService()),
        ),
      ],
      child: MaterialApp(
        title: 'Resep Masakan',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Inter',
        ),
        home: const DashboardPage(),
        routes: {
          '/dashboard': (context) => const DashboardPage(),
          '/recipes': (context) => const RecipeListPage(),
          '/add-recipe': (context) => const AddRecipePage(),
        },
      ),
    );
  }
}