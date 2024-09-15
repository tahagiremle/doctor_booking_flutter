import 'package:doctor_booking_flutter/pages/homepage.dart';
import 'package:doctor_booking_flutter/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? name, mail, password;

  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (password != null && name != null && mail != null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: mail!, password: password!);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Registered Successfully",
          style: GoogleFonts.nunito(fontSize: 20),
        )));
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
      } on FirebaseAuthException catch (e) {
        if (e.code == "weak-password") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            "Password Provided is too weak",
            style: GoogleFonts.nunito(fontSize: 20),
          )));
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            "Account Already exists",
            style: GoogleFonts.nunito(fontSize: 20),
          )));
        }
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
              padding: EdgeInsets.only(
                left: 30,
                top: 50,
              ),
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 255, 211, 182),
                    Color.fromARGB(255, 220, 164, 124),
                    Color(0xFFb4817e),
                  ],
                ),
              ),
              child: Text(
                "Create Your\nAccount",
                style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 30),
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
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
                      "Name",
                      style: GoogleFonts.nunito(
                          color: Color.fromARGB(255, 158, 95, 50),
                          fontSize: 23,
                          fontWeight: FontWeight.w700),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Name';
                        }
                        return null;
                      },
                      controller: namecontroller,
                      decoration: InputDecoration(
                        hintText: "Name",
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      "Gmail",
                      style: GoogleFonts.nunito(
                          color: Color.fromARGB(255, 158, 95, 50),
                          fontSize: 23,
                          fontWeight: FontWeight.w700),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter E-mail';
                        }
                        return null;
                      },
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        hintText: "Gmail",
                        prefixIcon: Icon(Icons.mail),
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      "Password",
                      style: GoogleFonts.nunito(
                          color: Color.fromARGB(255, 158, 95, 50),
                          fontSize: 23,
                          fontWeight: FontWeight.w700),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Password';
                        }
                        return null;
                      },
                      controller: passwordcontroller,
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.password),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 60),
                    GestureDetector(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            mail = emailcontroller.text;
                            name = namecontroller.text;
                            password = passwordcontroller.text;
                          });
                        }
                        registration();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 255, 211, 182),
                                Color.fromARGB(255, 220, 164, 124),
                                Color(0xFFb4817e),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: Text(
                            "SIGN UP",
                            style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Already have an account?",
                          style: GoogleFonts.nunito(
                              color: Color.fromARGB(255, 46, 31, 35),
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LogIn(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Sign In",
                            style: GoogleFonts.nunito(
                                color: Color.fromARGB(255, 78, 53, 60),
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
