import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
>>>>>>> fritz
import 'login_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _formKey = GlobalKey<FormState>();

void main() {
  runApp(const SignUp());
}

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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

<<<<<<< HEAD
  // Function to show the validation dialog
  void showDialogValidation(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm Information'),
            content: const Text(
              'By signing in, you agree to the use of your information and enhance your experience.',
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context, 'Cancel');
                    },
                  ),
                  TextButton(
                    child: const Text('Confirm'),
                    onPressed: () {
                      Navigator.pop(context, 'Confirm');
                      // Navigate to the LoginPage after confirmation
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          );
        },
      );
    } else {
      // If validation fails, show an error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content:
                const Text('Please make sure all fields are correctly filled.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
=======
  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'username': _usernameController.text.trim(),
          'email': _emailController.text.trim(),
          'created_at': FieldValue.serverTimestamp(),
        });

        await _showDialog(context, 'Success', 'Account created successfully!');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } catch (e) {
        _showDialog(context, 'Error',
            'Failed to create account: The username or email address is already in use by another account.');
      }
>>>>>>> fritz
    }
  }

  Future<void> _showDialog(
      BuildContext context, String title, String message) async {
    await showDialog(
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
<<<<<<< HEAD
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 15, 22),
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
      backgroundColor: Color.fromARGB(255, 0, 15, 22),
=======
      backgroundColor: const Color.fromARGB(255, 0, 15, 22),
>>>>>>> fritz
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
<<<<<<< HEAD
                    Column(
                      children: [
                        Text(
                          "Sign In",
                          style: TextStyle(
                            color: Color(0xffe3eed4),
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Create Your Account!",
                          style:
                              TextStyle(color: Color(0xffe3eed4), fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 50),
                // Username field
                Container(
                  width: 500,
                  child: TextFormField(
                    style: TextStyle(color: Color(0xffe3eed4)),
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Icon(
                          Icons.person,
                          color: Color(0xffe3eed4),
                        ),
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffe3eed4), width: 2.0),
                      ),
                      labelText: 'Username',
                      labelStyle: TextStyle(color: Color(0xffe3eed4)),
                      hintText: 'Enter your usrname',
                      hintStyle: TextStyle(color: Color(0xffe3eed4)),
                    ),
                    validator: validateUsername,
                  ),
                ),
                SizedBox(height: 20),
                // Email field
                Container(
                  width: 500,
                  child: TextFormField(
                    style: TextStyle(color: Color(0xffe3eed4)),
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Icon(
                          Icons.email,
                          color: Color(0xffe3eed4),
                        ),
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffe3eed4), width: 2.0),
                      ),
                      labelText: 'E-mail Address',
                      labelStyle: TextStyle(color: Color(0xffe3eed4)),
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(color: Color(0xffe3eed4)),
                    ),
                    validator: validateEmail,
                  ),
                ),
                SizedBox(height: 20),
                // Password field
                Container(
                  width: 500,
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    style: TextStyle(color: Color(0xffe3eed4)),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffe3eed4), width: 2.0),
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Icon(
                          Icons.lock,
                          color: Color(0xffe3eed4),
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Color(0xffe3eed4),
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      border: const OutlineInputBorder(),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Color(0xffe3eed4)),
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(color: Color(0xffe3eed4)),
                    ),
                    validator: validatePassword,
                  ),
                ),
                SizedBox(height: 20),
                // Confirm Password field
                Container(
                  width: 500,
                  child: TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: !_isConfirmPasswordVisible,
                    style: TextStyle(color: Color(0xffe3eed4)),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffe3eed4), width: 2.0),
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Icon(
                          Icons.check,
                          color: Color(0xffe3eed4),
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Color(0xffe3eed4),
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordVisible =
                                !_isConfirmPasswordVisible;
                          });
                        },
                      ),
                      border: const OutlineInputBorder(),
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(color: Color(0xffe3eed4)),
                      hintText: 'Confirm your password',
                      hintStyle: TextStyle(color: Color(0xffe3eed4)),
                    ),
                    validator: validateConfirmPassword,
                  ),
=======
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
>>>>>>> fritz
                ),
                const SizedBox(height: 20),
                buildTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hint: 'Enter your password',
                  icon: const Icon(Icons.lock, color: Color(0xffe3eed4)),
                  obscureText: !_isPasswordVisible,
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
                  obscureText: !_isConfirmPasswordVisible,
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
                  width: 500,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
<<<<<<< HEAD
                      backgroundColor: Color(0xffe3eed4),
                    ),
                    onPressed: () {
                      showDialogValidation(context);
                    },
=======
                      backgroundColor: const Color(0xffe3eed4),
                    ),
                    onPressed: _signUp,
>>>>>>> fritz
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
                  "Or sign up with",
                  style: TextStyle(color: Color(0xffe3eed4)),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        FontAwesomeIcons.facebook,
                        color: Color(0xffe3eed4),
                      ),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        FontAwesomeIcons.google,
                        color: Color(0xffe3eed4),
                      ),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        FontAwesomeIcons.twitter,
                        color: Color(0xffe3eed4),
                      ),
                    ),
                  ],
                ),
<<<<<<< HEAD

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.facebook,
                          color: Color(0xffe3eed4),
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.twitter,
                          color: Color(0xffe3eed4),
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.instagram,
                          color: Color(0xffe3eed4),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // Already have an account text
=======
                const SizedBox(height: 20),
>>>>>>> fritz
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(color: Color(0xffe3eed4)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xffe3eed4),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
