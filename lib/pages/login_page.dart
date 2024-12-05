import 'signup_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:main/pages/homepage.dart';

final _formKey = GlobalKey<FormState>();

class UpdateLogin extends StatelessWidget {
  const UpdateLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ciales_ponce',
      debugShowCheckedModeBanner: true,
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isSecurePassword = true;

  // Validation for email
  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Please enter a valid email';
    }
    return null;
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
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Color(0xffe3eed4)),
                  textAlign: TextAlign.center,
                ),
              ),
              const Center(
                child: Text(
                  'Enter your credential to login',
                  style: TextStyle(fontSize: 15, color: Color(0xffe3eed4)),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 50),
              //EmailTextfield
              SizedBox(
                width: 500,
                child: TextFormField(
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
                      borderSide: BorderSide(color: Color(0xffe3eed4), width: 2.0),
                    ),
                  ),
                  validator: validateEmail,
                ),

              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 500,
                child: TextFormField(
                  obscureText: _isSecurePassword,
                  style: TextStyle(color: Color(0xffe3eed4)), // Text color
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Color(0xffe3eed4)), // Label color
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(color: Color(0xffe3eed4)), // Hint color
                    prefixIcon: Icon(Icons.lock, color: Color(0xffe3eed4)), // Prefix icon color
                    suffixIcon: togglePassword(), // Password visibility toggle button
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffe3eed4), width: 2.0), // Focused border
                    ),
                  ),
                  validator: (pass) => pass!.length <= 8
                      ? 'Password should contain more than 8 characters'
                      : null,
                ),
              ),

              const SizedBox(height: 35),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    _formKey.currentState!.validate();
                  },
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
                 
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, 
                    children: [
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.facebook,
                          color: Color(0xffe3eed4), 
                        ),
                        onPressed: () {
                        },
                      ),
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.twitter,
                          color: Color(0xffe3eed4), 
                        ),
                        onPressed: () {
                        },
                      ),
                      IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.instagram,
                          color: Color(0xffe3eed4), 
                        ),
                        onPressed: () {
                        },
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 80),
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
                      child: const Text("Sign In",
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
            ? Icon(Icons.visibility_off)
            : Icon(Icons.visibility));
  }
}