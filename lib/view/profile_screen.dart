import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/view/chat_screen.dart';
import 'package:untitled/view/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var name = "";
  var email = "";
  var mobile = "";
  var password = "";

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("name") ?? "0";
    email = prefs.getString("email") ?? "0";
    mobile = prefs.getString("mobile") ?? "0";
    password = prefs.getString("password") ?? "0";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile Screen",
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.white,
        elevation: 2.0,
        shadowColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const SizedBox(height: 80),
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  "https://img.freepik.com/free-vector/blue-circle-with-white-user_78370-4707.jpg"), // Replace this with your image path
            ),
            const SizedBox(height: 20),
            Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Mobile App Developer',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            _buildInfoCard(Icons.email, 'Email', email),
            _buildInfoCard(Icons.phone, 'Phone', mobile),
            _buildInfoCard(Icons.password, 'Password', password),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () {
                    Get.to(const ChatScreen());
                  },
                  icon: const Icon(Icons.chat),
                  label: Text('Chat with Me'),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () async{
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    // prefs.clear();
                    prefs.setBool("isLogin", false);
                    Get.off(const LoginScreen());
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                ),
                const Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String subtitle) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.blue,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
