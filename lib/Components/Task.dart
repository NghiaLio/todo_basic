// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Task extends StatelessWidget {
  
  final List task;
  final int i;
  Function(BuildContext) deleteDialog;
  VoidCallback navigation_Edit;
  Function( bool?)? checked;

  Task({super.key, required this.task, required this.i,
   required this.deleteDialog,
   required this.navigation_Edit,
   required this.checked,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        closeThreshold: 0.2,
        motion: const ScrollMotion(), 
        children: [
          SlidableAction(
            // onPressed: (context)=>deleteDialog(task[i].ID),
            onPressed:deleteDialog,
            spacing: 8,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            backgroundColor: Colors.red,
            icon: Icons.delete,
            label: 'DELETE',
          )
        ]
      ),
      child: Card(
        margin:const EdgeInsets.only(bottom: 5),
        elevation: 4.0,
        shape:const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ListTile(
                onTap:navigation_Edit,
                leading: Checkbox(
                  value: task[i].is_completed, 
                  onChanged:checked,
                  activeColor: Colors.grey,
                ),
                title: Text(
                  task[i].title,
                  style:TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    decoration: task[i].is_completed ? TextDecoration.lineThrough : TextDecoration.none,
                    color: task[i].is_completed ? Colors.grey.withOpacity(0.8) : Colors.black,
                    overflow: TextOverflow.ellipsis
                  ),
                ),
              ),
              task[i].is_completed == true ? Padding(
                padding: const EdgeInsets.only(right: 5),
                // child: Text(task[i].timeCompleted),
                child: Text('kkkk'),
              ) : Container()
            ],
          ),
        ),
      ),
    );
  }
}