import 'package:flutter/material.dart';
import 'models/recipe.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const RecipeBookApp());
}

class RecipeBookApp extends StatefulWidget {
  const RecipeBookApp({super.key});

  @override
  State<RecipeBookApp> createState() => _RecipeBookAppState();
}

class _RecipeBookAppState extends State<RecipeBookApp> {
  // Example recipes
  final List<Recipe> _recipes = [
    Recipe(
      name: 'Spaghetti Bolognese',
      ingredients: 'Spaghetti, beef, tomato sauce, garlic, onion, olive oil',
      instructions: 'Cook pasta. Brown beef. Add sauce. Mix and serve.',
    ),
    Recipe(
      name: 'Pancakes',
      ingredients: 'Flour, eggs, milk, sugar, baking powder, butter',
      instructions: 'Mix ingredients. Pour on griddle. Flip when bubbles form.',
    ),
    Recipe(
      name: 'Tacos',
      ingredients: 'Tortillas, beef, cheese, lettuce, salsa',
      instructions: 'Cook beef, fill tortillas, add toppings, and serve.',
    ),
  ];

  void _toggleFavorite(Recipe recipe) {
    setState(() {
      recipe.isFavorite = !recipe.isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe Book',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: HomeScreen(recipes: _recipes, onToggleFavorite: _toggleFavorite),
    );
  }
}
