class Ingredients{
  String? id;
  List? ingredients;

  Ingredients({this.id});

  Map<String, dynamic> toJson() => {
    'id': id,

  };

  //returns user object
  static Ingredients fromJson (Map<String, dynamic>json)=>Ingredients(
    id: json['id'],

  );

}