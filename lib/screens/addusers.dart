import 'package:anotherrecipeapp/api/firebase_api.dart';
import 'package:anotherrecipeapp/databasehelper.dart';
import 'package:anotherrecipeapp/models/recipe.dart';
import 'package:anotherrecipeapp/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:path/path.dart';

class Addusers extends StatefulWidget {
  const Addusers({Key? key}) : super(key: key);

  @override
  _AddusersState createState() => _AddusersState();
}

class _AddusersState extends State<Addusers> {
  var xx;
  UploadTask? task;
  File? file;
  final controllerName = TextEditingController();
  final controllerCategory = TextEditingController();
  final controllerPreparationtime = TextEditingController();
  final controllerInstructions = TextEditingController();

  DatabaseHelper _db = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : 'No File Selected';
    return Scaffold(
      appBar: AppBar(
        title: Text('Add user'),
        actions: [
          IconButton(
            onPressed: () {
              _db.logout(context);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: controllerName,
            decoration: InputDecoration(labelText: "Name"),
          ),
          const SizedBox(height: 24,),
          TextField(
            controller: controllerCategory,
            decoration: InputDecoration(labelText: "Category"),

          ),
          const SizedBox(height: 24,),
          TextField(
            controller: controllerPreparationtime,
            decoration: InputDecoration(labelText: "Preparation Time"),

          ),
          const SizedBox(height: 24,),
          TextField(
            controller: controllerInstructions,
            decoration: InputDecoration(labelText: "Instructions"),

          ),
          ElevatedButton(
            child: Text(
                "select file"
            ),
            onPressed: selectFile,
          ),
          Text(
            fileName,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          ElevatedButton(
         child: Text(
           "upload file"
         ),
            onPressed: uploadFile,
          ),

          const SizedBox(height: 24,),
          ElevatedButton(onPressed: (){

            final recipe = Recipe (

              //document id
              //id: docUser.id,
              name: controllerName.text,
              category: controllerCategory.text,
              preparationtime: controllerPreparationtime.text,
              instructions: controllerInstructions.text,
              recipeimage: xx,




            );
            _db.createUser(recipe);
            Navigator.pop(context);

          }, child: Text('Create'))

        ],
      ),
    );


  }
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'recipeimages/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');

    xx = urlDownload;

    // FirebaseFirestore.instance
    //     .collection('Users')
    //     .doc()
    //     .update({
    //   "recipeimage": urlDownload
    // }).then((result){
    //   print("new USer true");
    // }).catchError((onError){
    //   print("onError");
    // });
  }
}
