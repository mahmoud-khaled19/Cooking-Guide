class MealFilter {
  List<Meals>? meals;

  MealFilter.fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      meals = <Meals>[];
      json['meals'].forEach((v) {
        meals!.add(Meals.fromJson(v));
      });
    }
  }
}

class Meals {
  String? mealName;
  String? mealImage;
  String? mealId;

  Meals.fromJson(Map<String, dynamic> json) {
    mealName = json['strMeal'];
    mealImage = json['strMealThumb'];
    mealId = json['idMeal'];
  }
}
