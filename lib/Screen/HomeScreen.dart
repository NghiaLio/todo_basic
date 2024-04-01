
// ignore_for_file: non_constant_identifier_names, unrelated_type_equality_checks

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:todo_basic/Components/Dialog.dart';
import 'package:todo_basic/Components/Task.dart';
import 'package:todo_basic/Screen/TaskScreen.dart';
import 'package:todo_basic/model/data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<TaskData> task = [];
  List<TaskData> task_need = [];
  List<TaskData> task_Completed = [];
  TextEditingController titleText = TextEditingController();
  TextEditingController cate = TextEditingController();

  bool? isCompleted;
  
  String time_completed ='';


// FETCH API 
@override
  void initState() {
    super.initState();
    getData();
  }

// GET
Future<void> getData() async{
  const url = 'https://api.nstack.in/v1/todos';
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  final jsonbody = response.body;
  final Body = jsonDecode(jsonbody);
  final result = Body['items'] as List;
  setState(() {
    task = result.map(
        (e) => TaskData(
          ID: e['_id'], 
          // userID: e['userId'], 
          title: e['title'], 
          description: e['description'],
          is_completed: e['is_completed'],
          // timeCompleted: e['time_Completed']
        )
      ).toList();
    task_Completed = task.where((element) => element.is_completed == true).toList();
    task_need = task.where((element) => element.is_completed == false).toList();
  });
}

// POST
Future<void> postData() async{
  const url = 'https://api.nstack.in/v1/todos';
  final uri = Uri.parse(url);
  final body = {
    // "userId" :1,
    "title":titleText.text,
    "is_completed":false,
    "description":cate.text,
    // "time_Completed":time_completed
  };
  final jsonBody = jsonEncode(body);
  final response = await http.post(
    uri,
    body: jsonBody,
    headers: {
      'Content-type': 'application/json; charset=UTF-8',
    },
  );
  if(response.statusCode <300){
    showSnackBar('Create task Succesfully');
  }else{
    showSnackBar('Error 403');
  }
}
// PUT 

Future<void> putData(String ID) async{
  final url = 'https://api.nstack.in/v1/todos/${ID}';
  final uri = Uri.parse(url);
  final body = {
    // "userId" :1,
    "title":titleText.text,
    "is_completed":isCompleted,
    "description":cate.text
  };
  final jsonBody = jsonEncode(body);
  final response = await http.put(
    uri,
    body: jsonBody,
    headers: {
      'Content-type': 'application/json; charset=UTF-8',
    },
  );
  if(response.statusCode <300){
    showSnackBar('Update task Succesfully');
  }else{
    showSnackBar('Error 403');
  }
}

// PATCH
Future<void> patchData(String ID) async{
  final url = 'http://10.0.2.2:1080/v1/api/task/${ID}';
  final uri = Uri.parse(url);
  final body = {
    // "userId" :1,
    "is_completed":isCompleted,
    // "time_Completed":time_completed,
  };
  final jsonBody = jsonEncode(body);
  await http.patch(
    uri,
    body: jsonBody,
    headers: {
      'Content-type': 'application/json',
    },
  );
  // if(response.statusCode <300){
  //   showSnackBar('Update task Succesfully');
  // }else{
  //   showSnackBar('Error');
  // }
}

// DELETE
Future<void> deleteData(String ID) async{
  final url = 'https://api.nstack.in/v1/todos/${ID}';
  final uri = Uri.parse(url);
  final response = await http.delete(uri)  ;
  if(response.statusCode <300){
    showSnackBar('DELETE COMPLETED');
  }else{
    showSnackBar('DELETE FAIL $ID');
  }
}
  
// tick Checkbox
void checked(int index, bool? value, String id, dynamic task){
    // final now = DateTime.now();
    // final parseTime = DateTime.parse('$now');
    // final hour = parseTime.hour;
    // final day = parseTime.day;
    // final month = parseTime.month;
    // final minutes = parseTime.minute;
    setState(() {
      task[index].is_completed = !task[index].is_completed;
      isCompleted =  task[index].is_completed;
      titleText.text = task[index].title;
      cate.text = task[index].description;
      // time_completed = '$hour:$minutes  $day-$month';
    });
    putData(id);
    final filter_1 = task.where((element) => element.is_completed == true).toList();
    final filter_2 = task.where((element) => element.is_completed == false).toList();
    setState(() {
      task_Completed = filter_1;
      task_need = filter_2;
    });
    _refresh();
  }

//Navigator
void navigationAdd(){
  final route = MaterialPageRoute(
    builder: (c)=> Edit_Add_Scr(
      textController:titleText,
      onPressed: (){
        postData();
        _refresh();
        Navigator.pop(context);
      },
      isAddTask: true,
      cate: cate,
      onSelectedPopUpItem: onSelectedPopUpItem,
    )
  );
  Navigator.push(context, route);
}

void navigation_Edit(dynamic data, String ID){
  setState(() {
    isCompleted = data.completed;
  });
  final route = MaterialPageRoute(
    builder: (c)=> Edit_Add_Scr(
      textController:titleText,
      onPressed: (){
        putData(ID);
        // print(titleText.text);
        Navigator.pop(context);
        _refresh();
        
      },
      isAddTask: false,
      data: data,
      cate: cate,
      onSelectedPopUpItem: onSelectedPopUpItem,
      Id_Task: ID,
    )
  );
  Navigator.push(context, route);
}

//SnackBar
void showSnackBar(String message){
  final snackBar = SnackBar(content: Text(message));
 ScaffoldMessenger.of( context).showSnackBar(snackBar);
}

// Dialog
void deleteDialog(String ID){
  showDialog(
    context: context, 
    builder: (context)=>dialog(
      onYes: (){
        deleteData(ID);
        Navigator.pop(context);
        // Lọc ra các element có id khác với id xóa rồi gộp thành list mới
        final filter_3 = task_need.where((element) => element.ID != ID).toList();
        final filter_4 = task_Completed.where((element) => element.ID != ID).toList();
        setState(() {
          task_need = filter_3;
          task_Completed = filter_4;
        });
      },
      onNO: () =>Navigator.pop(context) ,
    )
  );
}

// Refresh
Future<void> _refresh() async{
  return await getData();
}

// onSelectedPopUpItem 
void onSelectedPopUpItem(String value,String id){
    if(value == 'favorite'){
      
    }
    else if(value == 'completed'){
      setState(() {
        isCompleted = true;
      });
      patchData(id);
      showSnackBar('Task is Completed');

    }else{
      deleteData(id);
      _refresh();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: const Text(
          'ToDo',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: RefreshIndicator(
          onRefresh: _refresh,
          color: Colors.white,
          backgroundColor: Colors.orange,
          strokeWidth: 4,
          displacement: 30,
          child: ListView(
            children: [
              Text(
                'Tasks (${task_need.length})',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20,),
              task_need.isNotEmpty ? Column(
                 children: [
                  for(int i=0; i< task_need.length; i++)
                    Task(
                      task: task_need,
                      i: i,
                      deleteDialog: (context)=>deleteDialog(task_need[i].ID),
                      navigation_Edit:()=>navigation_Edit(task_need[i],task_need[i].ID ) ,
                      checked: (value)=>checked(i, value, task_need[i].ID, task_need),
                    )
                 ]
              ) :const Center(child: Text('There are no task')),
              const SizedBox(height: 20,),
              Text(
                'Tasks is completed (${task_Completed.length})',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20,),
              task_Completed.isNotEmpty ?Column(
                 children: [
                  for(int i=0; i< task_Completed.length; i++)
                    Task(
                      task: task_Completed,
                      i: i,
                      deleteDialog: (context)=>deleteDialog(task_Completed[i].ID),
                      navigation_Edit: () =>navigation_Edit(task_Completed[i],task_Completed[i].ID ) ,
                      checked: (value)=>checked(i, value, task_Completed[i].ID, task_Completed),
                    )
                 ]
              ):const Center(child: Text('There are no task completed')) ,
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 20, bottom: 20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50)
            ),
            shadowColor: Colors.blue
          
          ),
          onPressed:navigationAdd, 
          child:const Icon(Icons.add, size: 30,)
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}