import 'package:flutter/material.dart';
import 'sign_up.dart';
import 'profile_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  //  void _login() async {

  //   // Simulate a delay to mimic a network request

  //   await Future.delayed(Duration(seconds: 2));


  //   // Check if the email and password match the predefined credentials

  //   if (_email == 'soulemangenie@gmailcom' && _password == 'admin') {

  //     // Login successful, navigate to the profile page

  //     Navigator.pushReplacement(

  //       context,

  //       MaterialPageRoute(builder: (context) => ProfilePage(email: _email)),

  //     );

  //   } else {

  //     // Login failed, show an error message

  //     ScaffoldMessenger.of(context).showSnackBar(

  //       SnackBar(content: Text('Invalid email or password')),

  //     );

  //   }

  // }

  void _login() async {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    final url = Uri.parse('http://localhost:5000/conn.php'); // Replace with your API URL
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': _email, 'password': _password}),
    );
    

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['message'] == 'Login successful') {
        // Login successful, navigate to the profile page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage(email: _email)),
        );
      } else {
        // Login failed, show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password')),
        );
      }
    } else {
      // Error making the request, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error making request')),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
                onSaved: (value) => _email = value!,
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
                onSaved: (value) => _password = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _login();
                  }
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  );
                },
                child: const Text('Don\'t have an account? Sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}