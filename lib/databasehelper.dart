import 'package:anotherrecipeapp/models/recipe.dart';
import 'package:anotherrecipeapp/models/users.dart';
import 'package:anotherrecipeapp/screens/loginpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as u;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatabaseHelper{


  Future createUser(Recipe recipe) async{

    final docUser = FirebaseFirestore.instance.collection('recipe').doc();

    recipe.id = docUser.id;
    //using doc refernnce
    //map
    // final json = {
    //   'name': name,
    //   'age': 21,
    //   'birthday': DateTime(2001, 7, 09),
    // };

    // final user = User (
    //   //document id
    //   id: docUser.id,
    //   name: name,
    //   age: 21,
    //   birthday: DateTime(2001, 7, 09),
    // );

    final json = recipe.toJson();
    //create document and write data to firebase
    await docUser.set(json);
  }



  Future updateRecipe(Recipe recipe, {String? idy}) async{

    final docUser = FirebaseFirestore.instance.collection('recipe').doc(idy);

    //recipe.id = docUser.id;

    final json = recipe.toJson();
    //create document and write data to firebase
    await docUser.update(json);
  }

  Future createRecipe(Recipe recipe) async{

    final docUser = FirebaseFirestore.instance.collection('recipe').doc();

    recipe.id = docUser.id;


    final json = recipe.toJson();
    //create document and write data to firebase
    await docUser.set(json);
  }

  deletemethod(String id){
    final docUser = FirebaseFirestore.instance.collection('recipe').doc(id);
    docUser.delete();

  }


  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await u.FirebaseAuth.instance.signOut();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  Stream<List<Recipe>>readUsers()=>FirebaseFirestore.instance.collection('recipe')
      //to get all the documents from the firebase connection
  //returns true snapshot of map string dynamic so we get sm json data bak
      .snapshots()
      //convert json data to user objects
      .map((snapshot) =>
      //going over all snapshot documents
      snapshot.docs.map((doc) =>
      //and convert each document back to user objects
         Recipe.fromJson(doc.data())).toList());

  //works
  Stream<List<Recipe>>readCategoryDetails(String queryString)=>FirebaseFirestore.instance.collection('recipe').where(
      'category', isEqualTo: queryString
  )
  //to get all the documents from the firebase connection
  //returns true snapshot of map string dynamic so we get sm json data bak
      .snapshots()
  //convert json data to user objects
      .map((snapshot) =>
  //going over all snapshot documents
  snapshot.docs.map((doc) =>
  //and convert each document back to user objects
  Recipe.fromJson(doc.data())).toList());



  countDocuments(String id, String recipeid) async {
    QuerySnapshot _myDoc = await FirebaseFirestore.instance.collection('recipe').where(
        'favourites', arrayContains: id
    ).where(
        'recipe', isEqualTo: recipeid
    ).get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    print(_myDocCount.length);  // Count of Documents in Collection
  }

  //works
  Stream<List<Recipe>>readFavouriteDetails(String queryString)=>FirebaseFirestore.instance.collection('recipe').where(
      'favourites', arrayContains: queryString
  )
  //to get all the documents from the firebase connection
  //returns true snapshot of map string dynamic so we get sm json data bak
      .snapshots()
  //convert json data to user objects
      .map((snapshot) =>
  //going over all snapshot documents
  snapshot.docs.map((doc) =>
  //and convert each document back to user objects
  Recipe.fromJson(doc.data())).toList());


  //works
  Stream<List<Recipe>>readNameDetails(String queryString)=>FirebaseFirestore.instance.collection('recipe').where(
      'name'.toLowerCase(), isEqualTo: queryString
  )
  //to get all the documents from the firebase connection
  //returns true snapshot of map string dynamic so we get sm json data bak
      .snapshots()
  //convert json data to user objects
      .map((snapshot) =>
  //going over all snapshot documents
  snapshot.docs.map((doc) =>
  //and convert each document back to user objects
  Recipe.fromJson(doc.data())).toList());


  Future<User?> readInji() async{

    final docUser = FirebaseFirestore.instance.collection('recipe').doc('tnZBAEWOuD5A0lsniQoC');
    final snapshot = await docUser.get();


    if(snapshot.exists){
      return User.fromJson(snapshot.data()!);
    }

  }

  Future queryData(String queryString) async{
    return FirebaseFirestore.instance.collection('recipe').where(
      'category', isGreaterThanOrEqualTo: queryString
    ).get();
  }


  // Stream<List<Recipe>>get notices{
  //   final CollectionReference noticeCollection=FirebaseFirestore.instance.collection('recipe');
  //   final Query unapproved = noticeCollection.where("status", isEqualTo: "unapproved");
  //   return unapproved.snapshots().map(_noticeListFromSnapshot);
  // }




}