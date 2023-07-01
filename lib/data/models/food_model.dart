class Food {
  final String name, id;
  final String? imageUrl, description, servingSizeUnit;
  final double? servingSize, numberOfServings, calories, carbs, protein, fat;
  final List<dynamic> nutrients;

  Food(
      {required this.id,
      required this.name,
      required this.nutrients,
      this.calories,
      this.carbs,
      this.fat,
      this.protein,
      this.description,
      this.imageUrl,
      this.servingSize,
      this.servingSizeUnit,
      this.numberOfServings = 1});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
        id: json['fdcId'].toString(),
        name: (json['description'] as String).toLowerCase(),
        nutrients: json['foodNutrients'] as List<dynamic>,
        servingSize: json['servingSize'],
        servingSizeUnit: json['servingSizeUnit']);
  }

  Map<String, dynamic> nutrientFromMap(int nutrientId) {
    for (var nutrient in nutrients) {
      if (nutrient['nutrientId'] == nutrientId) {
        return nutrient;
      }
    }
    return {
      'value': 0,
      'unitName': '?',
    };
  }
}
