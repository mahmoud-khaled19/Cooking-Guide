class AreaModel {
  List<Meals>? meals;

  AreaModel({this.meals});

  AreaModel.fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      meals = <Meals>[];
      json['meals'].forEach((v) {
        meals!.add(Meals.fromJson(v));
      });
    }
  }
}

class Meals {
  String? areaName;

  Meals({this.areaName});

  Meals.fromJson(Map<String, dynamic> json) {
    areaName = json['strArea'];
  }
}
