import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coffee_shop/screens/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../db/firebase_services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  late String _email;
  late String _password;

  bool _isLoading = false;

  void _navigateToHomePage(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(user: user),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final auth = FirebaseAuth.instance;
        final userCredential = await auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        final user = userCredential.user;

        setState(() {
          _isLoading = false;
        });

        if (user != null) {
          FirebaseService.addUser(user);
          _navigateToHomePage(user);
          // Navigate to the home page or some other screen after successful sign up.
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          _isLoading = false;
        });

        if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('The email address is already in use.'),
              duration: Duration(seconds: 3),
            ),
          );
        } else if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('The password provided is too weak.'),
              duration: Duration(seconds: 3),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to sign up.'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to sign up.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.only(top: 100, bottom: 40),
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: AssetImage("images/Coffee1.jpg"),
                fit: BoxFit.cover,
                opacity: 0.6,
              ),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sign Up",
                    style: GoogleFonts.pacifico(
                      fontSize: 50,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                      child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 16.0),
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Name',
                                  filled: true,
                                  fillColor: Colors.white),
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name.';
                                }
                                return null;
                              },
                              onChanged: (value) {},
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Email',
                                  filled: true,
                                  fillColor: Colors.white),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email address.';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                _email = value.trim();
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Password',
                                  filled: true,
                                  fillColor: Colors.white),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password.';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                _password = value.trim();
                              },
                            ),
                            const SizedBox(height: 32.0, width: 32.0),
                            ElevatedButton(
                              onPressed: _isLoading ? null : _submitForm,
                              child: _isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text('Sign up'),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.orange),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))
                ])));
  }
}
