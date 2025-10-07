import 'package:flutter/material.dart';
import '../models/recipe.dart';

class DetailsScreen extends StatefulWidget {
  final Recipe recipe;
  final Function(Recipe) onToggleFavorite;

  const DetailsScreen({
    super.key,
    required this.recipe,
    required this.onToggleFavorite,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final recipe = widget.recipe;

    return Scaffold(
      appBar: AppBar(title: Text(recipe.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ingredients:', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(recipe.ingredients),
            const SizedBox(height: 20),
            Text(
              'Instructions:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(recipe.instructions),
            const Spacer(),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    widget.recipe.isFavorite = !widget.recipe.isFavorite;
                  });
                  widget.onToggleFavorite(recipe);
                  //notify parent
                  widget.onToggleFavorite(widget.recipe);
                },
                icon: Icon(
                  recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                label: Text(
                  recipe.isFavorite
                      ? 'Remove from Favorites'
                      : 'Add to Favorites',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
