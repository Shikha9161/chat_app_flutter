import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/view/login_screen.dart';
import 'package:untitled/view/profile_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    initView();

  }

  initView()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool check=prefs.getBool("isLogin")??false;
    Timer(const Duration(seconds: 5), () {
     if(check){
       Get.off(const ProfileScreen());
     }else{
       Get.off(const LoginScreen());
     }
    });


  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.chat,color: Colors.pink,size: 50,),
            SizedBox(height: 10,),
            Text("My Chat App",style: TextStyle(fontSize: 16),),
            SizedBox(height: 50,),
            CircularProgressIndicator(color: Colors.pink,)

          ],
        ),
      )
    );
  }
}
