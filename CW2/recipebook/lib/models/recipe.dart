class Recipe {
  final String name;
  final String ingredients;
  final String instructions;
  bool isFavorite;

  Recipe({
    required this.name,
    required this.ingredients,
    required this.instructions,
    this.isFavorite = false,
  });
}
