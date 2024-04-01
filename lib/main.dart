import 'package:flutter/material.dart';
import 'package:todo_basic/Screen/HomeScreen.dart';

import 'Components/bottomNav.dart';
import 'Screen/CalendarScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      theme: ThemeData(
        
        primarySwatch: Colors.orange,
        
      ),
      home: const ToDoApp(),
    );
  }
}

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  int _selectedIndex =0;
  final List<Widget> _WidgetOption = <Widget> [
    const HomeScreen(),
    const CalendarScreen(),
  ];

  // selectPage
  void onSelectedPage(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xffEAF0F9) ,
      body:_WidgetOption[_selectedIndex],
      
      bottomNavigationBar:BottomNavigation(index: _selectedIndex,onTap: onSelectedPage,) ,
    );
  }
}
