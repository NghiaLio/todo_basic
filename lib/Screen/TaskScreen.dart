// ignore_for_file: prefer_typing_uninitialized_variables, no_logic_in_create_state, must_be_immutable, non_constant_identifier_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class Edit_Add_Scr extends StatefulWidget {
  final TextEditingController cate ;
  final Id_Task;

  final data;
  final bool isAddTask;
  Function(String, String) onSelectedPopUpItem;
  VoidCallback onPressed;
  final textController;

   Edit_Add_Scr({super.key, required this.textController, 
   required this.onPressed, required this.isAddTask,
   this.data,   required this.cate,
    required this.onSelectedPopUpItem,
    this.Id_Task
   });

  @override
  State<Edit_Add_Scr> createState() => _AddTaskState(
    textController, onPressed, isAddTask, 
    data, cate, onSelectedPopUpItem,
    Id_Task
  );
}

class _AddTaskState extends State<Edit_Add_Scr> {
  final keyForm = GlobalKey<FormState>();

  final data;
  final Id_Task;
 
  final TextEditingController cate;
  final bool isAddTask;
  Function(String, String) onSelectedPopUpItem;
  VoidCallback onPressed;
  final textController;
  // String categories ;
  List<String> items = [
    'No categories',
    'Work',
    'Personal',
    'Health'
  ];

  List<PopupMenuEntry<String>>popUpItem =const [
    PopupMenuItem(
      value: 'favorite',
      child: Text('Favorite', style: TextStyle(fontWeight: FontWeight.w500),),
    ),
    PopupMenuItem(
      value: 'completed',
      child: Text('Completed',style: TextStyle(fontWeight: FontWeight.w500),),
    ),
    PopupMenuItem(
      value: 'delete',
      child: Text('Delete',style: TextStyle(fontWeight: FontWeight.w500),),
    ),
  ];

  @override
  void initState() {
    
    super.initState();
    if(!isAddTask){
      textController.text = data.title;
      cate.text = data.Categories;
    }else{
      textController.text = '';
      // cate.text = 'Work';
      cate.text = items[0];
    }
  }

 

  _AddTaskState(this.textController, this.onPressed, 
  this.isAddTask,this.data,this.cate, 
  this.onSelectedPopUpItem, this.Id_Task
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          isAddTask == true ? 'Add Task' : 'Task',
          style:const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        actions: [
          isAddTask == false ?PopupMenuButton(
            itemBuilder: (context) =>popUpItem,
            onSelected: (String value){
              onSelectedPopUpItem(value,Id_Task);
            },
            tooltip: "More",
            iconSize: 30,
          ):Container()
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  isAddTask == true ? 'Add a task item' : 'Title',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              Form(
                key: keyForm,
                child: TextFormField(
                  controller: textController,
                  decoration: InputDecoration(
                    
                    hintText: 'Enter your title...',
                    hintStyle: TextStyle(fontSize: 24, color: Colors.grey[600]),
                    border:const OutlineInputBorder(
                      gapPadding: 6.0,
                      borderSide: BorderSide(width: 0.7),
                      borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                    
                  ),
                  style:const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 10,
                  maxLength: 600,
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Enter your task';
                    }else{
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(height: 30,),
              Column(
                crossAxisAlignment:CrossAxisAlignment.start ,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButton<String>(
                      elevation: 4,
                      borderRadius:const BorderRadius.all(Radius.circular(20)),
                      iconSize: 30,
                      menuMaxHeight: 200,
                      padding: const EdgeInsets.only(right: 150),
                      style:const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                      ),
                      value: cate.text,
                      items: items.map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem(
                            value: value,
                            child: Text(value)
                          )
                      ).toList(), 
                      onChanged: (String? newValue){
                        
                        setState(() {
                          if(newValue == null){
                            cate.text = 'Work';
                          }else{
                            cate.text = newValue ;
                          }
                          // cate.text = newValue;
                        });
                        // print(cate.text);
                      }
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50,),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 10),
                    shape:const  RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    )
                  ),
                  onPressed:(){
                    if(keyForm.currentState!.validate()){
                      onPressed();
                    }
                  } , 
                  child:  Text(
                    isAddTask == true ?'ADD' : 'Save',
                    style:const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}