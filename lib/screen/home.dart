import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/add_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final CollectionReference fetchData=FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xD011CFD6),
        centerTitle:true,
        title:const Text(
          "Todo",
          textAlign: TextAlign.center,
        ),
      ),
      floatingActionButton: AddTask(),
      body: StreamBuilder(
        stream: fetchData.snapshots(), 
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot ){
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context,index){
                final DocumentSnapshot documentSnapshot=streamSnapshot.data!.docs[index];
                return Material(
                  borderRadius: BorderRadius.circular(10),
                  child:
                  ListTile(
                    title: Text(
                      documentSnapshot['Task']
                    ),
                    subtitle: Text("${DateFormat("yyyy-MM-dd 'at' kk:mm").format((documentSnapshot as dynamic)['Date'].toDate())}"),
                    leading: Checkbox(
                      value: documentSnapshot["isCompleted"], 
                      onChanged: (value)async{
                        if(documentSnapshot["isCompleted"]==false){
                          await FirebaseFirestore.instance.collection("users").doc(documentSnapshot["question_id"]).update(
                            {"isCompleted":true}
                          );
                        }else{
                          await FirebaseFirestore.instance.collection("users").doc(documentSnapshot["question_id"]).update(
                            {"isCompleted":false}
                          );
                        }
                      }
                    ),
                    trailing:InkWell(
                      onTap: ()async{ 
                        await FirebaseFirestore.instance.collection("users").doc(documentSnapshot["question_id"].toString()).delete();
                      },
                      child: const Icon(Icons.delete),
                    )
                  ),
                );
              },
            );
          }else{
          return const Center(
            child: Text("Add Task"),
          );
          }
        },
      ),
    );
  }
}