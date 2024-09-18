import 'package:doctor_booking_flutter/pages/homepage.dart';
import 'package:doctor_booking_flutter/pages/login.dart';
import 'package:doctor_booking_flutter/services/database.dart';
import 'package:doctor_booking_flutter/services/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_string/random_string.dart';

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
        // ignore: unused_local_variable
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: mail!, password: password!);
        String id = randomAlpha(10);

        await SharedPreferencesHelper().saveUserName(namecontroller.text);
        await SharedPreferencesHelper().saveUserEmail(emailcontroller.text);
        await SharedPreferencesHelper().saveUserId(id);

        Map<String, dynamic> userInfoMap = {
          "Name": namecontroller.text,
          "Email": emailcontroller.text,
          "Id": id,
        };
        await DatabaseMethods().addUserDetails(userInfoMap, id);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Registered Successfully",
          style: GoogleFonts.nunito(fontSize: 20),
        )));
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
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
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 30,
              top: 50,
            ),
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
              "Create Your\nAccount",
              style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 30),
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
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
                    "Name",
                    style: GoogleFonts.nunito(
                        color: const Color.fromARGB(255, 1, 73, 102),
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
                    decoration: const InputDecoration(
                      hintText: "Name",
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    "Gmail",
                    style: GoogleFonts.nunito(
                        color: const Color.fromARGB(255, 1, 73, 102),
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
                    decoration: const InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.password),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 60),
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
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Already have an account?",
                        style: GoogleFonts.nunito(
                            color: Colors.black,
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
                          builder: (context) => const LogIn(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Sign In",
                          style: GoogleFonts.nunito(
                              color: Colors.black,
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
    );
  }
}
