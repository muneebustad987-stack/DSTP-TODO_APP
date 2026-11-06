import 'package:flutter/material.dart';
import 'package:my_multi_screen_project/constant/app_colors.dart';
import 'package:my_multi_screen_project/view/login.dart';

class SplashScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  
  @override
  void initState() {
    onInitCalled();
    super.initState();
  }

Future<void>onInitCalled() async {
  await Future.delayed(Duration(seconds: 3));
  var route = MaterialPageRoute(builder: (_)=>LoginScreenUi());
  Navigator.pushReplacement(context, route);
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "DSTP-TODO",
              style: TextStyle(color: AppColors.primaryText, fontSize: 30),
            ),
            CircularProgressIndicator(
              backgroundColor: Colors.amber,
            )
          ],
        ),
      ),
    );
  }
}
