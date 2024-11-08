import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseServices {
  final _fire=FirebaseFirestore.instance;

  DateTime  now = DateTime.now();
  create(String task) async {
    await _fire.collection("users").add({
      "Task":task,
      "Date":now,
      "isCompleted":false,
      "question_id":""
    }).then((DocumentReference doc)async{
      await _fire.collection("users").doc(doc.id).update({"question_id":doc.id});
      debugPrint(doc.id);
    });  
 }

  delete(String doc_id) async {
    await _fire.collection("users").doc(doc_id).delete();
  }

}