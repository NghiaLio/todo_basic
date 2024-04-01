// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class dialog extends StatelessWidget {
  Function()? onYes;
  Function()? onNO;
  dialog({super.key, required this.onNO, required this.onYes});

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      title:const Text(
        'DELETE Task',
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
      ),
      content:const Text(
        'Do you gonna delete this task',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
      ),
      actions: [
        TextButton(
          onPressed:onYes, 
          child:const Text('Yes',style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600))
        ),
        TextButton(
          onPressed:onNO, 
          child:const Text('No',style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600))
        ),
      ],
    );
  }
}