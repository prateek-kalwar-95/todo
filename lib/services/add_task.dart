import 'package:flutter/material.dart';
import 'package:todo/services/curd_firebase.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final myController = TextEditingController();
  final _dbServices=DatabaseServices();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
    child:const Icon(Icons.add),
        onPressed: (){
          showModalBottomSheet(
            isScrollControlled: true,
            context: context, 
            builder: ((context){
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom
                ),
                child:Container(
                  // color: Colors.white70,
                  height:200 ,
                  child:Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // const DropdownMenu(
                              //   enableSearch: false,
                              //   label: Text("Prority"),
                              //   dropdownMenuEntries: [
                              //     DropdownMenuEntry(leadingIcon:Icon(Icons.flag,color: Colors.red,) ,value:"High", label: "High",),
                              //     DropdownMenuEntry(leadingIcon:Icon(Icons.flag,color: Colors.yellow,),value: Colors.yellow, label: "medium"),
                              //     DropdownMenuEntry(leadingIcon:Icon(Icons.flag,color: Colors.green,),value: Colors.green, label: "low"),
                              //   ],
                              // ),
                              const Spacer(
                                flex: 2,
                              ),
                              TextButton(
                                child: Text("Save"),
                                onPressed: (){
                                  if (myController.text.isNotEmpty) {
                                    debugPrint(myController.text);
                                    _dbServices.create(myController.text);
                                    setState(() {
                                      myController.clear();
                                    });
                                    Navigator.pop(context);
                                  }else{
                                    return  ;
                                  } 
                                },
                              )  
                            ],
                          ),
                        ),
                        TextField(
                          controller: myController,
                          minLines: 1,
                          maxLines: 2,
                          autofocus: true,
                          decoration: const InputDecoration(
                            hintText: 'Write task.....',
                          ),
                          keyboardType: TextInputType.multiline,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })
          );
        },
  );
  }
}