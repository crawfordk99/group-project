import 'package:flutter/material.dart';
import 'package:group_project/services/firebase_auth_service.dart';
import 'package:group_project/main_screen.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // const MyHomePage({super.key, required this.title});
  //
  // final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String profilePicUrl = 'https://www.bing.com/images/search?view=detailV2&ccid=LN6kJFUF&id=129B9F508C8F0923C483EEBBFC7BD144C3A5CC35&thid=OIP.LN6kJFUFhV-hbWaHW7qwkAHaHa&mediaurl=https%3a%2f%2fi.pinimg.com%2f736x%2f5b%2f00%2f9d%2f5b009de7c5445cfc41835aa57dc1859e.jpg&cdnurl=https%3a%2f%2fth.bing.com%2fth%2fid%2fR.2cdea4245505855fa16d66875bbab090%3frik%3dNcylw0TRe%252fy77g%26pid%3dImgRaw%26r%3d0&exph=724&expw=724&q=purple+camera+logo+for+pictures&simid=608032718677566935&FORM=IRPRST&ck=96A8EACB5296F3D2F97EFA160386C2EC&selectedIndex=34&itb=0';
  final _email = TextEditingController();
  final _password = TextEditingController();
  final FirebaseAuthService _authService = FirebaseAuthService();
  bool _login = true;

  @override
  void initState() {
    super.initState();
    _authService.connectAuthEmulator();
  }
  _handleSubmit() async {
    if (_login) {
      final user = await _authService.logIn(_email.text, _password.text);
      if (user != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
      }
    } else {
      if (_password.text.length >= 6) { // Fixed: Use `>=` instead of `>`
        final user = await _authService.createUser(_email.text, _password.text);
        if (user != null) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
        }
      } else {
        // Ensure UI is built before showing SnackBar
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Password must be at least 6 characters long."),
              backgroundColor: Colors.red,
            ),
          );
        });
      }
    }
  }


  void _handleCreateAccount() {
    setState((){
      _login = !_login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
         title: Text("Verification page"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Logo
              Center(
                child: GestureDetector(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(profilePicUrl),
                    child: Icon(Icons.camera_alt, size: 40, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Username Input
              TextFormField(
                controller: _email,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,

                ),
                keyboardType: TextInputType.emailAddress,

              ),
              const SizedBox(height: 16),

              // Password Input
              TextFormField(
                controller: _password,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),

              // Login Button
              ElevatedButton(

                onPressed: _handleSubmit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Enter'),
              ),

              const SizedBox(height: 10),

              // Create Account Button
              ElevatedButton(
                onPressed: _handleCreateAccount,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: _login
                    ? const Text('Create Account')
                    : const Text('LoginPage'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
