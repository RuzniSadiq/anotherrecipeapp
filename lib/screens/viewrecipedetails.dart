import 'package:anotherrecipeapp/animation/animation.dart';
import 'package:anotherrecipeapp/databasehelper.dart';
import 'package:anotherrecipeapp/models/users.dart';
import 'package:anotherrecipeapp/mywidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

import 'addusers.dart';

class ViewRecipeDetails extends StatefulWidget {
  //const ViewRecipeDetails({Key? key}) : super(key: key);

  final String? recipeid;
  final String? name;
  final String? category;
  final String? preparationtime;
  final String? recipeimage;
  final List? ingredients;
  final String? rool;
  final String? email;
  final String? id;
  final String? instructions;

  //constructor
  ViewRecipeDetails(
      {required this.id,
      required this.name,
      required this.category,
      required this.preparationtime,
      required this.recipeimage,
      required this.ingredients,
      required this.email,
      required this.recipeid,
      required this.rool,
      required this.instructions});

  @override
  _ViewRecipeDetailsState createState() => _ViewRecipeDetailsState();
}

class _ViewRecipeDetailsState extends State<ViewRecipeDetails> {
  //List items = [];

  DatabaseHelper _db = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    var x = widget.ingredients;
    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
          slivers: <Widget>[
            // SliverPersistentHeader(
            //   delegate:
            //   //delegate: MySliverAppBar(expandedHeight: 300, info: widget.info),
            //   pinned: true,
            // ),

            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  DelayedDisplay(
                    delay: const Duration(microseconds: 600),
                    child: Container(
                      height: 300,
                      foregroundDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        image: DecorationImage(
                          image: NetworkImage(
                              '${widget.recipeimage}'),
                          fit: BoxFit.cover,

                        ),

                      ),
                    ),
                  ),
                  DelayedDisplay(
                    delay: const Duration(microseconds: 600),
                    child: Container(
                      padding: const EdgeInsets.all(26.0),
                      child: Text(
                        widget.name!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 26.0, vertical: 10),
                    child: DelayedDisplay(
                      delay: const Duration(microseconds: 700),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(-2, -2),
                              blurRadius: 12,
                              color: Color.fromRGBO(0, 0, 0, 0.05),
                            ),
                            BoxShadow(
                              offset: Offset(2, 2),
                              blurRadius: 5,
                              color: Color.fromRGBO(0, 0, 0, 0.10),
                            )
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Column(
                                children: [
                                  Text(
                                      widget.preparationtime.toString() +
                                          " Min",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  Text(
                                    "Ready in",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 2,
                              color: Theme.of(context).primaryColor,
                            ),
                            Flexible(
                              flex: 1,
                              child: Column(
                                children: [
                                  (x != null)
                                  ?Text('${widget.ingredients!.length}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)):
                                  Text("0",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  Text(
                                    "Ingredients",
                                    style:
                                    TextStyle(color: Colors.grey.shade600),
                                  )

                                ],
                              ),
                            ),


                          ],
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(26.0),
                    child: DelayedDisplay(
                      delay: const Duration(microseconds: 700),
                      child: Text(
                        "Ingredients",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),

                  (x == null)
                    ?
                  Padding(
                    padding: const EdgeInsets.only(left: 33.0),
                    child: DelayedDisplay(
                        delay: const Duration(microseconds: 600),
                        child: Text("No ingredients")
                      ),
                  )
                      :

                  Padding(
                    padding: const EdgeInsets.only(left: 33.0),
                    child:


                    DelayedDisplay(

                        delay: const Duration(microseconds: 600),

                        child:
                        Wrap(
                          //alignment: WrapAlignment.spaceBetween,
                          direction: Axis.horizontal,

                            children: [
                              for (var nw in x)
                              Text("$nw, "),
                            ],

                        )
                    ),

                  ),

                  if (widget.instructions != null)
                    Padding(
                      padding: const EdgeInsets.all(26.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Instructions",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Html(
                            data: widget.instructions,
                            style: {
                              'p': Style(
                                fontSize: FontSize.large,
                                color: Colors.black,
                              ),
                            },
                          ),
                        ],
                      ),
                    ),





                ],
              ),

            )

            ]



      ),
      // child: Container(
      //   child: Column(children: [
      //     Container(
      //       width: double.infinity,
      //       height: 300.0,
      //       foregroundDecoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(5.0),
      //         image: DecorationImage(
      //           image: NetworkImage(
      //               '${widget.recipeimage}'),
      //           fit: BoxFit.cover,
      //
      //         ),
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(left: 14.0,top: 50.0),
      //       child: Align(
      //         alignment: Alignment.topLeft,
      //         child: Text(
      //           "${widget.name}",
      //           style: TextStyle(
      //             fontSize: 30.0,
      //             fontWeight: FontWeight.bold
      //           ),
      //         ),
      //       ),
      //     ),
      //     Container(
      //
      //
      //     ),
      //
      //   ],),
      // ),
      //
    ));
  }
//get one specific user and display in listtile
// Widget buildUser(User user) => Padding(
//   padding: const EdgeInsets.all(16.0),
//   child: Container(
//     decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(16)),
//     child: GestureDetector(
//       onTap: (){
//         // Navigator.of(context).push(MaterialPageRoute(
//         //     builder: (context) => TaskCardWidget(name: user.name,)));
//       },
//       child: ListTile(
//
//
//
//         leading: CircleAvatar(child: Text('${user.age}'),),
//         title: Text(user.name!),
//         subtitle: Text(user.birthday!.toIso8601String()),
//
//
//       ),
//     ),
//   ),
// );
}