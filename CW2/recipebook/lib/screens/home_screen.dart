import 'package:flutter/material.dart';
import '../models/recipe.dart';
import 'details_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  final List<Recipe> recipes;
  final Function(Recipe) onToggleFavorite;

  const HomeScreen({
    super.key,
    required this.recipes,
    required this.onToggleFavorite,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Recipe Book'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FavoritesScreen(
                    favoriteRecipes: widget.recipes
                        .where((recipe) => recipe.isFavorite)
                        .toList(),
                    onToggleFavorite: widget.onToggleFavorite,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.recipes.length,
        itemBuilder: (context, index) {
          final recipe = widget.recipes[index];
          return ListTile(
            title: Text(recipe.name),
            trailing: Icon(
              recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: recipe.isFavorite ? Colors.red : null,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailsScreen(
                    recipe: recipe,
                    onToggleFavorite: widget.onToggleFavorite,
                  ),
                ),
              ).then((_) => setState(() {})); // refresh after return
            },
          );
        },
      ),
    );
  }
}
