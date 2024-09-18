import 'package:doctor_booking_flutter/pages/homepage.dart';
import 'package:doctor_booking_flutter/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String? mail, password;

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  userLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: mail!, password: password!);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "No user Found for that Email",
            style: GoogleFonts.nunito(fontSize: 18, color: Colors.black),
          ),
        ));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Wrong Password Provided by User",
            style: GoogleFonts.nunito(fontSize: 18, color: Colors.black),
          ),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 30, top: 50),
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF91eae4),
                    Color(0xFF86a8e7),
                    Color(0xFF7f7fd5),
                  ],
                ),
              ),
              child: Text(
                "Hello\nSign in!",
                style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 30),
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Gmail",
                      style: GoogleFonts.nunito(
                        color: const Color.fromARGB(255, 1, 73, 102),
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter E-mail';
                        }
                        return null;
                      },
                      controller: emailcontroller,
                      decoration: const InputDecoration(
                        hintText: "Gmail",
                        prefixIcon: Icon(Icons.mail),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      "Password",
                      style: GoogleFonts.nunito(
                        color: const Color.fromARGB(255, 1, 73, 102),
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Password';
                        }
                        return null;
                      },
                      controller: passwordcontroller,
                      decoration: const InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.password),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgot Password?",
                          style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 60),
                    GestureDetector(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            mail = emailcontroller.text;
                            password = passwordcontroller.text;
                          });
                          userLogin();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF91eae4),
                              Color(0xFF86a8e7),
                              Color(0xFF7f7fd5),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            "SIGN IN",
                            style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Don't have account?",
                          style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUp(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Sign up",
                            style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
