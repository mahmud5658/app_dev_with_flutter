import 'package:flutter/material.dart';
import 'package:taskmanager/style/style.dart';

BottomNavigationBar bottomNav(currentIndex, onItemTapped) {
  return BottomNavigationBar(items: [
     BottomNavigationBarItem(
        icon: Icon(
          Icons.list_alt,
        ),
        label: 'New'),
         BottomNavigationBarItem(
        icon: Icon(
          Icons.access_time_rounded,
        ),
        label: 'Progress'),
         BottomNavigationBarItem(
        icon: Icon(
          Icons.check_circle_outline_rounded,
        ),
        label: 'Completed'),
         BottomNavigationBarItem(
        icon: Icon(
          Icons.cancel_outlined,
        ),
        label: 'Canceled'),
  ],
  showSelectedLabels: true,
  showUnselectedLabels: true,
  currentIndex: currentIndex,
  selectedItemColor: colorGreen,
  unselectedItemColor: colorLightGray,
  onTap: onItemTapped,
  type: BottomNavigationBarType.fixed,
  );
}
