import 'dart:convert';

import 'package:anotherrecipeapp/databasehelper.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/recipe.dart';

//here we are creating the cards
class TaskCardWidget extends StatelessWidget {
  //adding the ? allows the variable to be nullable
  //the title variable is for the title
  final List? name;
  final String? id;



  //constructor
  TaskCardWidget({this.id, this.name});

  @override

  Widget build(BuildContext context) {
    DatabaseHelper _db = DatabaseHelper();
    print(id);
    final controllers = TextEditingController();
    return new MaterialApp(
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Ingredients Used'),
          ),
          body: Column(
            children: [
              TextField(
                controller: controllers,
              ),
              const SizedBox(height: 24,),
              ElevatedButton(onPressed: (){

                var list = [controllers.text];
                FirebaseFirestore.instance.collection('recipe').doc(id).update({"ingredients": FieldValue.arrayUnion(list)});
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

              }, child: Text('Create')),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: new Center(
                  child:
                    (name != null)
                  ?Column( // Or Row or whatever :)
                      children: [ for (var nw in name!) Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          height: 30.0,
                            width: 200.0,
                            decoration: BoxDecoration(
                              color: Colors.teal,
                                border: Border.all(color: Colors.blueAccent)

                            ),
                            child: Text(nw)),
                      ) ]
                  )
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
    return name!.map((text) => Text(text, style: TextStyle(color: Colors.blue),)).toList();
  }

  Widget getTextWidgets(List<String> strings)
  {
    //return new Row(children: strings.map((item) => new Text(item)).toList());
    return Row(children: [ for (var nw in name!) Text(nw) ]);
  }
}


