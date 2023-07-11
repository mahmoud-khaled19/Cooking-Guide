class RandomMealModel {
  List<Meals>? meals;

  RandomMealModel.fromJson(Map<String, dynamic> json) {
    if (json['meals'] != null) {
      meals = <Meals>[];
      json['meals'].forEach((v) {
        meals!.add(Meals.fromJson(v));
      });
    }
  }
}

class Meals {
  String? mealId;
  String? mealName;
  String? mealCountry;
  String? mealInstructions;
  String? mealImage;
  String? mealVideo;
  String? mealSource;
  String? mealContent1;
  String? mealContent2;
  String? mealContent3;
  String? mealContent4;
  String? mealContent5;
  String? mealContent6;
  String? mealContent7;
  String? mealContent8;
  String? mealContent9;
  String? mealContent10;
  String? mealContent11;
  String? mealContent12;
  String? mealContent13;
  String? mealContent14;
  String? mealContent15;
  String? mealContentQuantity1;
  String? mealContentQuantity2;
  String? mealContentQuantity3;
  String? mealContentQuantity4;
  String? mealContentQuantity5;
  String? mealContentQuantity6;
  String? mealContentQuantity7;
  String? mealContentQuantity8;
  String? mealContentQuantity9;
  String? mealContentQuantity10;
  String? mealContentQuantity11;
  String? mealContentQuantity12;
  String? mealContentQuantity13;
  String? mealContentQuantity14;
  String? mealContentQuantity15;

  Meals.fromJson(Map<String, dynamic> json) {
    mealId = json['idMeal'];
    mealName = json['strMeal'];
    mealCountry = json['strArea'];
    mealInstructions = json['strInstructions'];
    mealImage = json['strMealThumb'];
    mealVideo = json['strYoutube'];
    mealContent1 = json['strIngredient1'];
    mealContent2 = json['strIngredient2'];
    mealContent3 = json['strIngredient3'];
    mealContent4 = json['strIngredient4'];
    mealContent5 = json['strIngredient5'];
    mealContent6 = json['strIngredient6'];
    mealContent7 = json['strIngredient7'];
    mealContent8 = json['strIngredient8'];
    mealContent9 = json['strIngredient9'];
    mealContent10 = json['strIngredient10'];
    mealContent11 = json['strIngredient11'];
    mealContent12 = json['strIngredient12'];
    mealContent13 = json['strIngredient13'];
    mealContent14 = json['strIngredient14'];
    mealContent15 = json['strIngredient15'];
    mealContentQuantity1 = json['strMeasure1'];
    mealContentQuantity2 = json['strMeasure2'];
    mealContentQuantity3 = json['strMeasure3'];
    mealContentQuantity4 = json['strMeasure4'];
    mealContentQuantity5 = json['strMeasure5'];
    mealContentQuantity6 = json['strMeasure6'];
    mealContentQuantity7 = json['strMeasure7'];
    mealContentQuantity8 = json['strMeasure8'];
    mealContentQuantity9 = json['strMeasure9'];
    mealContentQuantity10 = json['strMeasure10'];
    mealContentQuantity11 = json['strMeasure11'];
    mealContentQuantity12 = json['strMeasure12'];
    mealContentQuantity13 = json['strMeasure13'];
    mealContentQuantity14 = json['strMeasure14'];
    mealContentQuantity15 = json['strMeasure15'];
    mealSource = json['strSource'];
  }
}
