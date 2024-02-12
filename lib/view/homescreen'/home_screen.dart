import 'package:flutter/material.dart';
import 'package:studentmanagement_provider/utils/constants.dart';
import 'package:studentmanagement_provider/view/student_list_screen.dart/student_list_screen.dart';
import 'package:studentmanagement_provider/view/widgets/app_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants().blackColor,
      appBar: const PreferredSize(
          preferredSize: Size(double.infinity, 90),
          child: AppBarWidget(title: 'Students Hub')),
      body: const SafeArea(
          child: Column(
        children: [
          MainNavigatingButtons(
            buttonText: 'View Students',
            navigatingpage: StudentListScreen(),
          ),
          MainNavigatingButtons(
            buttonText: 'Add New Students ',
            navigatingpage: StudentListScreen(),
          )
        ],
      )),
    );
  }
}

class MainNavigatingButtons extends StatelessWidget {
  const MainNavigatingButtons({
    super.key,
    required this.navigatingpage,
    required this.buttonText,
  });
  final StudentListScreen navigatingpage;
  final String buttonText;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => navigatingpage,
            ));
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        color: Constants().whiteColor,
        height: 70,
        width: double.infinity,
        child: Text(buttonText),
      ),
    );
  }
}
