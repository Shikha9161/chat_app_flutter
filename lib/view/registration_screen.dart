import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool visible = true;
  bool checkKey = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration Screen",style: TextStyle(fontSize: 16),),
        backgroundColor: Colors.white,
        elevation: 2.0,
        shadowColor: Colors.pink,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Name",
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                    keyboardType:TextInputType.text,
                    controller: nameController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      hintText: "Enter name",
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "name can't be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  "Email Address",
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                    keyboardType:TextInputType.emailAddress,
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
                  "Mobile Number",
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  maxLength: 10,
                    keyboardType: TextInputType.number,
                    controller: mobileController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      hintText: "Enter mobile number",
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "mobile number can't be empty";
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
                       regitration();
                      }

                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.pink.shade600, // Background Color
                    ),
                    child: const Text(
                      'Register',
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
                      'Old User? ',
                      style: TextStyle(
                          fontSize: 16.0, color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text(
                        'Login',
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
  regitration()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("name", nameController.text);
    await prefs.setString("email", emailController.text);
    await prefs.setString("mobile", mobileController.text);
    await prefs.setString("password", passwordController.text);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Register Successful",style: TextStyle(color: Colors.white),),backgroundColor: Colors.green,));
    Get.back();
  }
}
