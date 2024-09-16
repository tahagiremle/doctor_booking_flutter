import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_booking_flutter/admin/booking_admin.dart';
import 'package:doctor_booking_flutter/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController userpasswordcontroller = TextEditingController();

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
                "Admin\nPanel",
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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40),
                      Text(
                        "Username",
                        style: GoogleFonts.nunito(
                            color: Color.fromARGB(255, 158, 95, 50),
                            fontSize: 23,
                            fontWeight: FontWeight.w700),
                      ),
                      TextFormField(
                        controller: usernamecontroller,
                        decoration: InputDecoration(
                          hintText: "Username",
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
                        controller: userpasswordcontroller,
                        decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.password),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 60),
                      GestureDetector(
                        onTap: () {
                          loginAdmin();
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
                              "LOG IN",
                              style: GoogleFonts.nunito(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  loginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then(
      (snapshot) {
        snapshot.docs.forEach(
          (result) {
            if (result.data()["id"] != usernamecontroller.text.trim()) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Your id is not correct",
                    style: GoogleFonts.nunito(fontSize: 20),
                  ),
                ),
              );
            } else if (result.data()["password"] !=
                userpasswordcontroller.text.trim()) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Your password is not correct",
                    style: GoogleFonts.nunito(fontSize: 20),
                  ),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingAdmin(),
                ),
              );
            }
          },
        );
      },
    );
  }
}
