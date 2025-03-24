import 'package:flutter/material.dart';
import 'package:group_project/services/firebase_auth_service.dart';

class MyHomePage extends StatefulWidget {
  // const MyHomePage({super.key, required this.title});
  //
  // final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _email = '';
  String _password = '';
  bool _login = true;

  void _handleSubmit() {
    if (_login == true) {
      FirebaseAuthService().logIn(_username, _password);
    }
    else if(_login == false){
      FirebaseAuthService().createUser(email, password)// ⚠️ Never log passwords in production!
    }
  }

  void _handleCreateAccount() {
    if(_login == false)
      {_login = true;}
    else{
      _login = false;// Implement navigation here
    }

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
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Password Input
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
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
