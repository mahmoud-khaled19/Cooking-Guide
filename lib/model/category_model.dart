class CategoryModel {
  List<Meals>? meals;

  CategoryModel({this.meals});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      meals = <Meals>[];
      json['meals'].forEach((v) {
        meals!.add(Meals.fromJson(v));
      });
    }
  }
}

class Meals {
  String? categoryName;

  Meals({this.categoryName});

  Meals.fromJson(Map<String, dynamic> json) {
    categoryName = json['strCategory'];
  }
}
