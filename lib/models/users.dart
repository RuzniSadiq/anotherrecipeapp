import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  String? id;
  final String? name;
  final int? age;
  final DateTime? birthday;
  final List? ingredients;


  User({this.id, this.name, this.age, this.birthday, this.ingredients});

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'age': age,
    'birthday': birthday,
    'ingredients': ingredients
  };

  //returns user object
  static User fromJson (Map<String, dynamic>json)=>User(
    id: json['id'],
    name: json['name'],
    age: json['age'],
    birthday: (json['birthday'] as Timestamp).toDate(),
    ingredients: json['ingredients']
  );
}