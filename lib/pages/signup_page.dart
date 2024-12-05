import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/pages/homepage.dart';

final _formKey = GlobalKey<FormState>();

void main() {
  runApp(const SignUp());
}

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<SignUp> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegex.hasMatch(email);
    if (!isEmailValid) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Username is required';
    }
    if (username.length < 5) {
      // This ensures the username is at least 5 characters
      return 'Username must be at least 5 characters';
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < 8) {
      return 'Password should contain more than 8 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm Password is required';
    }
    if (confirmPassword != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  // Function to handle sign up
  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Create user with email and password
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Store user data (username, email, and created_at timestamp) in Firestore
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'username': _usernameController.text.trim(),
          'email': _emailController.text.trim(),
          'created_at': FieldValue.serverTimestamp(), // Add timestamp here
        });

        // Show success dialog
        _showDialog(context, 'Success', 'Account created successfully!');

        // Navigate to Login page after success
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } catch (e) {
        _showDialog(context, 'Error', 'Failed to create account: $e');
      }
    }
  }

  // Function to show a dialog
  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Helper function to build TextFormField
  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required Icon icon,
    required String? Function(String?) validator,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return SizedBox(
      width: 500,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Color(0xffe3eed4)),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(0.0),
            child: icon,
          ),
          suffixIcon: suffixIcon,
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffe3eed4), width: 2.0),
          ),
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xffe3eed4)),
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xffe3eed4)),
        ),
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 229, 233, 236),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xffe3eed4)),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Homepage(),
              ),
            );
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 0, 15, 22),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Color(0xffe3eed4),
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Text(
                  "Create Your Account!",
                  style: TextStyle(color: Color(0xffe3eed4), fontSize: 15),
                ),
                const SizedBox(height: 50),
                buildTextField(
                  controller: _usernameController,
                  label: 'Username',
                  hint: 'Enter your username (5 characters)',
                  icon: const Icon(Icons.person, color: Color(0xffe3eed4)),
                  validator: validateUsername,
                ),
                const SizedBox(height: 20),
                buildTextField(
                  controller: _emailController,
                  label: 'E-mail Address',
                  hint: 'Enter your email',
                  icon: const Icon(Icons.email, color: Color(0xffe3eed4)),
                  validator: validateEmail,
                ),
                const SizedBox(height: 20),
                buildTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hint: 'Enter your password',
                  icon: const Icon(Icons.lock, color: Color(0xffe3eed4)),
                  obscureText: true,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: const Color(0xffe3eed4),
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  validator: validatePassword,
                ),
                const SizedBox(height: 20),
                buildTextField(
                  controller: _confirmPasswordController,
                  label: 'Confirm Password',
                  hint: 'Confirm your password',
                  icon: const Icon(Icons.check, color: Color(0xffe3eed4)),
                  obscureText: true,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: const Color(0xffe3eed4),
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                  validator: validateConfirmPassword,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      backgroundColor: const Color(0xffe3eed4),
                    ),
                    onPressed: _signUp,
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 15, 22),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Or Sign In with",
                  style: TextStyle(
                    color: Color(0xffe3eed4),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.facebook,
                        color: const Color(0xffe3eed4),
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.twitter,
                        color: const Color(0xffe3eed4),
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.google,
                        color: const Color(0xffe3eed4),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: Color(0xffe3eed4)),
                    ),
                    TextButton(
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          color: Color(0xffe3eed4),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
