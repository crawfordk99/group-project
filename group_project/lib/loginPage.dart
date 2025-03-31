import 'package:flutter/material.dart';
import 'package:group_project/home_screen.dart';
import 'package:group_project/services/firebase_auth_service.dart';
import 'package:group_project/main_screen.dart';

class MyHomePage extends StatefulWidget {
  // const MyHomePage({super.key, required this.title});
  //
  // final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    if (_login == true) {
      final user = await _authService.logIn(_email.text, _password.text);
      if(user != null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
      }

    }
    else if(_login == false) {
      if (_password.text.length > 6){
        final user = await _authService.createUser(_email.text, _password.text);
        if (user != null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainScreen()));
        }
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Password must be at least 6 characters long."),
            backgroundColor: Colors.red,
          ),
        );
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
              ClipOval(
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue, // Background color
                ),
              ),
              const SizedBox(height: 16),

              // Username Input
              TextFormField(
                controller: _email,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
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
