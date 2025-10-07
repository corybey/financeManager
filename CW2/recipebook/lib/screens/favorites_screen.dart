import 'package:flutter/material.dart';
import '../models/recipe.dart';
import 'details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Recipe> favoriteRecipes;
  final Function(Recipe) onToggleFavorite;

  const FavoritesScreen({
    super.key,
    required this.favoriteRecipes,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Recipes')),
      body: favoriteRecipes.isEmpty
          ? const Center(child: Text('No favorite recipes yet!'))
          : ListView.builder(
              itemCount: favoriteRecipes.length,
              itemBuilder: (context, index) {
                final recipe = favoriteRecipes[index];
                return ListTile(
                  title: Text(recipe.name),
                  trailing: const Icon(Icons.favorite, color: Colors.red),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailsScreen(
                          recipe: recipe,
                          onToggleFavorite: onToggleFavorite,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
