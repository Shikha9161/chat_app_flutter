import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/view/profile_screen.dart';
import 'package:untitled/view/registration_screen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Screen",style: TextStyle(fontSize: 16),),
        backgroundColor: Colors.white,
        elevation: 2.0,
        shadowColor: Colors.pink,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 80.0,
                ),
                const Text(
                  "Email Address",
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  keyboardType:  TextInputType.emailAddress,
                  controller: emailController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      hintText: "Enter email address",
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "email can't be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  "Password",
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  obscureText: visible,
                  controller: passwordController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      hintText: "Enter username",
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(visible
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                        onPressed: () {
                          setState(() {
                            visible = !visible;
                          });
                        },
                      ),


                    ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "password can't be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 26.0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        login();
                      }

                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.pink.shade600, // Background Color
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 26.0,
                ),
                 Row(
                   crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'New User? ',
                      style: TextStyle(
                          fontSize: 16.0, color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {
                    Get.to(const RegistrationScreen());
                      },
                      child: const Text(
                        'Registration',
                        style: TextStyle(
                            fontSize: 16.0, color: Colors.pink),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  login()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email=prefs.getString("email") ?? "0";
    var password=prefs.getString("password") ?? "0";
    if(email!=emailController.text){
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email address not valid",style: TextStyle(color: Colors.white),),backgroundColor: Colors.red,));
    }else if(password!=passwordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password not valid",style: TextStyle(color: Colors.white),),backgroundColor: Colors.red,));

    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Successful",style: TextStyle(color: Colors.white),),backgroundColor: Colors.green,));
      prefs.setBool("isLogin", true);
      Get.off(const ProfileScreen());

    }

  }
}
