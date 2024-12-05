import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main/pages/homepage.dart';

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
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Sign up title section
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 0, left: 50, right: 50, bottom: 50),
                    ),
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
                ),
                SizedBox(height: 20),
                // Sign Up button
                Container(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      backgroundColor: Color(0xffe3eed4),
                    ),
                    onPressed: () {
                      showDialogValidation(context);
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 15, 22)),
                    ),
                  ),
                ),
                // Sign in with Google button
                const SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: const Text(
                    "Or Sign In with",
                    style: TextStyle(
                      color: Color(0xffe3eed4),
                      fontSize: 12,
                    ),
                  ),
                ),

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an Account?",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xffe3eed4),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 0, 15, 22),
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
                      },
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                          fontSize: 12,
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
