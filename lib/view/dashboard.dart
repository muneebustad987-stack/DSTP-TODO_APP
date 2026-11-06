import 'package:flutter/material.dart';
import 'package:my_multi_screen_project/constant/app_colors.dart';
import 'package:my_multi_screen_project/view/new_todo.dart';
import 'package:my_multi_screen_project/view/profile.dart';

class MyDashBoardUi extends StatefulWidget {
  const MyDashBoardUi({super.key});

  @override
  State<MyDashBoardUi> createState() => _MyDashBoardUiState();
}

class _MyDashBoardUiState extends State<MyDashBoardUi> {
  List<Widget> myScreenList = [MyNewScreen(), ProfilePage()];

  int myScreenIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: myScreenList[myScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: myScreenIndex,
        onTap: (index) {
          myScreenIndex = index;
          setState(() {});
        },

        backgroundColor: AppColors.taskCardBgColor,
        selectedItemColor: AppColors.fabColor,
        unselectedItemColor: AppColors.cancelIconColor,
        selectedLabelStyle: TextStyle(fontSize: 20),
        unselectedLabelStyle: TextStyle(fontSize: 18),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
