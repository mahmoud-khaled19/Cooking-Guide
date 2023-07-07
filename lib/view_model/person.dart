import 'package:hive/hive.dart';

part 'person.g.dart';

@HiveType(typeId: 1)
class Person {
  Person({
    required this.name,
    required this.cardCvv,
    required this.cardExpiryDate,
    required this.cardNumber,
  });

  @HiveField(0)
  String? name;

  @HiveField(1)
  String? cardNumber;

  @HiveField(2)
  String? cardCvv;

  @HiveField(3)
  String? cardExpiryDate;
}
