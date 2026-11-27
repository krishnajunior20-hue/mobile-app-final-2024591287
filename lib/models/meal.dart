class Meal {
  final String id;
  final String name;
  final String imageUrl;
  final String category;
  final String area;
  final String instructions;
  final List<String> ingredients;

  Meal({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.category = '',
    this.area = '',
    this.instructions = '',
    this.ingredients = const [],
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    final ingredients = <String>[];
    for (int i = 1; i <= 20; i++) {
      final name = json['strIngredient$i'];
      final measure = json['strMeasure$i'];
      if (name != null && name.toString().trim().isNotEmpty) {
        ingredients.add('${measure ?? ''} $name'.trim());
      }
    }
    return Meal(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      imageUrl: json['strMealThumb'] ?? '',
      category: json['strCategory'] ?? '',
      area: json['strArea'] ?? '',
      instructions: json['strInstructions'] ?? '',
      ingredients: ingredients,
    );
  }
}