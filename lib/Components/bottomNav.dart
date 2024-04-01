// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {

  final index;  
  Function(int)? onTap;
  BottomNavigation({super.key,required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
       
      iconSize: 32,
      // backgroundColor: ,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled, ),
          label: 'Home'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_sharp,),
          label: 'Calendar'
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.file_open_rounded,),
        //   label: 'File'
        // ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.settings,),
        //   label: 'settings'
        // ),
        
      ],
      currentIndex: index,
      selectedFontSize: 16,
      selectedItemColor:  Colors.orange,
      unselectedItemColor: Colors.black,
      onTap: onTap,
    );
  }
}