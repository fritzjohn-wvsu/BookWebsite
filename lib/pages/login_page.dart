import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'homepage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _formKey = GlobalKey<FormState>();

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  bool _isSecurePassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Firebase Authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Validation for email
  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Sign in with Firebase
  Future<void> _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Successful login
        if (userCredential.user != null) {
          // Show success dialog
          _showDialog(
              "Login Successful!",
              "You successfully login your account ${userCredential.user!.email}",
              true);
        }
      } on FirebaseAuthException catch (e) {
        // Handle Firebase Auth errors
        if (e.code == 'user-not-found') {
          _showDialog(
              "Login Failed", "No user found with this email address.", false);
        } else if (e.code == 'wrong-password') {
          _showDialog("Login Failed", "Incorrect password entered.", false);
        } else {
          _showDialog("Login Failed",
              "The email address or password you entered is incorrect.", false);
        }
      } catch (e) {
        // Catch all other errors
        _showDialog("Login Failed",
            "The email address or password you entered is incorrect.", false);
      }
    }
  }

  // Show success or error dialog
  void _showDialog(String title, String message, bool isSuccess) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Container(
            width: 400, // Set fixed width for the content
            height: 30, // Set fixed height for the content
            child: Column(
              children: [
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                if (isSuccess) {
                  // Navigate to the homepage if login is successful
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Homepage()),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 15, 22),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  'Welcome',
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffe3eed4)),
                  textAlign: TextAlign.center,
                ),
              ),
              const Center(
                child: Text(
                  'Enter your credentials to login',
                  style: TextStyle(fontSize: 15, color: Color(0xffe3eed4)),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 50),
              // Email Textfield
              SizedBox(
                width: 500,
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Color(0xffe3eed4)),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Color(0xffe3eed4)),
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(color: Color(0xffe3eed4)),
                    prefixIcon: Icon(Icons.mail, color: Color(0xffe3eed4)),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffe3eed4), width: 2.0),
                    ),
                  ),
                  validator: validateEmail,
                ),
              ),
              const SizedBox(height: 20),
              // Password Textfield
              SizedBox(
                width: 500,
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: _isSecurePassword,
                  style: TextStyle(color: Color(0xffe3eed4)),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Color(0xffe3eed4)),
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(color: Color(0xffe3eed4)),
                    prefixIcon: Icon(Icons.lock, color: Color(0xffe3eed4)),
                    suffixIcon: togglePassword(),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xffe3eed4), width: 2.0),
                    ),
                  ),
                  validator: (pass) => pass!.length <= 8
                      ? 'Password should contain more than 8 characters'
                      : null,
                ),
              ),
              const SizedBox(height: 35),
              // Login Button
              SizedBox(
                width: 500,
                child: ElevatedButton(
                  onPressed: _signIn,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    backgroundColor: Color(0xffe3eed4),
                  ),
                  child: const Text(
                    "Log In",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 15, 22),
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: const Text(
                  "Or Log In with",
                  style: TextStyle(
                    color: Color(0xffe3eed4),
                    fontSize: 12,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.facebook,
                        color: Color(0xffe3eed4)),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.twitter,
                        color: Color(0xffe3eed4)),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.google,
                        color: Color(0xffe3eed4)),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  'Forgot password?',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              // Sign up link
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffe3eed4),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()),
                        );
                      },
                      child: const Text("Sign Up",
                          style: TextStyle(
                            color: Color(0xffe3eed4),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Toggle Password Visibility
  Widget togglePassword() {
    return IconButton(
      color: Color(0xffe3eed4),
      onPressed: () {
        setState(() {
          _isSecurePassword = !_isSecurePassword;
        });
      },
      icon: _isSecurePassword
          ? const Icon(Icons.visibility_off)
          : const Icon(Icons.visibility),
    );
  }
}
