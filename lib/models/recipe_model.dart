class Recipe {
  final int id;
  String title, author, description;
  int cookingTime;
  int servings;
  // List<String> ingredients = [];
  String imageUrl;

  Recipe({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.cookingTime,
    required this.servings,
    required this.imageUrl,
    // required this.ingredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as int,
      title: json['title'] as String,
      author: json['sourceName'] as String,
      description: json['summary'] as String,
      cookingTime: json['readyInMinutes'] as int,
      servings: json['servings'] as int,
      imageUrl: json['image'] as String,
      // ingredients: json['extendedIngredients']
    );
  }

  // Demo model
  static List<Recipe> demoRecipe = [
    Recipe(
      id: 1,
      title: 'Gruyère, Bacon, and Spinach Scrambled Eggs',
      author: "Borat",
      description:
          'A touch of Dijon mustard, salty bacon, melty cheese, and a handful of greens seriously upgrades scrambled eggs, without too much effort!',
      cookingTime: 10,
      servings: 4,
      imageUrl: 'assets/images/img1.jpg',
      // ingredients: [
      //   '8 large eggs',
      //   '1 tsp. Dijon mustard',
      //   'Kosher salt and pepper',
      //   '1 tbsp. olive oil or unsalted butter',
      //   '2 slices thick-cut bacon, cooked and broken into pieces',
      //   '2 c. spinach, torn',
      //   '2 oz. Gruyère cheese, shredded',
      // ],
    ),
    Recipe(
      id: 2,
      title: 'Classic Omelet and Greens ',
      author: "Borat",
      description:
          'Sneak some spinach into your morning meal for a boost of nutrients to start your day off right.',
      cookingTime: 10,
      servings: 4,
      imageUrl: 'assets/images/img2.jpg',
      // ingredients: [
      //   '8 large eggs',
      //   '1 tsp. Dijon mustard',
      //   'Kosher salt and pepper',
      //   '1 tbsp. olive oil or unsalted butter',
      //   '2 slices thick-cut bacon, cooked and broken into pieces',
      //   '2 c. spinach, torn',
      //   '2 oz. Gruyère cheese, shredded',
      // ],
    ),
    Recipe(
      id: 3,
      title: 'Sheet Pan Sausage and Egg Breakfast Bake ',
      author: "Borat",
      description:
          'A hearty breakfast that easily feeds a family of four, all on one sheet pan? Yes, please.',
      cookingTime: 10,
      servings: 4,
      imageUrl: 'assets/images/img3.jpg',
      // ingredients: [
      //   '8 large eggs',
      //   '1 tsp. Dijon mustard',
      //   'Kosher salt and pepper',
      //   '1 tbsp. olive oil or unsalted butter',
      //   '2 slices thick-cut bacon, cooked and broken into pieces',
      //   '2 c. spinach, torn',
      //   '2 oz. Gruyère cheese, shredded',
      // ],
    ),
    Recipe(
      id: 4,
      title: 'Shakshuka',
      author: "Borat",
      description:
          'Just wait til you break this one out at the breakfast table: sweet tomatoes, runny yolks, and plenty of toasted bread for dipping.',
      cookingTime: 10,
      servings: 4,
      imageUrl: 'assets/images/img4.jpg',
      // ingredients: [
      //   '8 large eggs',
      //   '1 tsp. Dijon mustard',
      //   'Kosher salt and pepper',
      //   '1 tbsp. olive oil or unsalted butter',
      //   '2 slices thick-cut bacon, cooked and broken into pieces',
      //   '2 c. spinach, torn',
      //   '2 oz. Gruyère cheese, shredded',
      // ],
    ),
  ];
}