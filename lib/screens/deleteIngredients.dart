import 'dart:convert';

import 'package:anotherrecipeapp/databasehelper.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/recipe.dart';

//here we are creating the cards
class deleteIngredients extends StatelessWidget {
  //adding the ? allows the variable to be nullable
  //the title variable is for the title
  final List? ingredients;
  final String? id;

  //constructor
  deleteIngredients({this.id, this.ingredients});

  @override
  Widget build(BuildContext context) {
    DatabaseHelper _db = DatabaseHelper();
    print(id);
    final controllers = TextEditingController();
    return new SafeArea(
        child: Scaffold(
      // appBar: new AppBar(
      //   title: new Text('Ingredients Used'),
      // ),
      body: Column(
        children: [
          Container(
            height: 120.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFffffe6),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Delete Ingredients",
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          TextField(
            controller: controllers,
          ),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
              onPressed: () {
                var list = [controllers.text];
                // var val=[];   //blank list for add elements which you want to delete
                // val.add('Chocolate 250');
                // FirebaseFirestore.instance.collection("recipe").doc(widget.recipeid).update({
                //
                //   "ingredients":FieldValue.arrayRemove(val) });
                FirebaseFirestore.instance
                    .collection('recipe')
                    .doc(id)
                    .update({"ingredients": FieldValue.arrayRemove(list)});
                controllers..text = "";
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Row(
                    children: const [
                      Icon(
                        Icons.delete_forever_sharp,
                        color: Colors.red,
                      ),
                      SizedBox(width: 20),
                      Expanded(child: Text('Ingredient Added Successfully!')),
                    ],
                  ),
                ));
                // final user = Recipe (
                //   //document id
                //   //id: docUser.id,
                //
                //   ingredients:
                //   [
                //
                //     controllers.text
                //
                //   ],
                //
                //
                //
                // );
                //_db.createUser(user);
              },
              child: Text('Delete')),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: new Center(
              child: (ingredients != null)
                  ? Column(// Or Row or whatever :)
                      children: [
                      for (var nw in ingredients!)
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                              height: 30.0,
                              width: 200.0,
                              decoration: BoxDecoration(
                                  color: Colors.teal,
                                  border: Border.all(color: Colors.blueAccent)),
                              child: Text(nw)),
                        )
                    ])
                  : Text(id.toString()),
            ),
          ),
        ],
      ),
    ));
  }

  List<Text> createChildrenTexts() {
    // Method 1
//    List<Text> childrenTexts = List<Text>();
//    for (String name in list) {
//      childrenTexts.add(new Text(name, style: new TextStyle(color: Colors.red),));
//    }
//    return childrenTexts;

    // Method 2
    return ingredients!
        .map((text) => Text(
              text,
              style: TextStyle(color: Colors.blue),
            ))
        .toList();
  }

  Widget getTextWidgets(List<String> strings) {
    //return new Row(children: strings.map((item) => new Text(item)).toList());
    return Row(children: [for (var nw in ingredients!) Text(nw)]);
  }
}
