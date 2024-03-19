import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:studentmanagement_provider/view/student_list_screen.dart/student_list_screen.dart';
import 'package:studentmanagement_provider/viewmodel/student_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StudentProvider()),
      ],
      child: MaterialApp(
        home: AnimatedSplashScreen(
          splash: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Lottie.asset(
                  'assets/images/student.json',
                  width: 250,
                  height: 250,
                ),
              ),
              const Text(
                "Students Hub",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          nextScreen: const StudentListScreen(),
          splashIconSize: 500,
          duration: 3000,
          splashTransition: SplashTransition.fadeTransition,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
