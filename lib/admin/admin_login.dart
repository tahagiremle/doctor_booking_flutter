import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_booking_flutter/admin/booking_admin.dart';
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
                "Admin\nPanel",
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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        "Username",
                        style: GoogleFonts.nunito(
                            color: const Color.fromARGB(255, 1, 73, 102),
                            fontSize: 23,
                            fontWeight: FontWeight.w700),
                      ),
                      TextFormField(
                        controller: usernamecontroller,
                        decoration: const InputDecoration(
                          hintText: "Username",
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
                        controller: userpasswordcontroller,
                        decoration: const InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.password),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 60),
                      GestureDetector(
                        onTap: () {
                          loginAdmin();
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
                  builder: (context) => const BookingAdmin(),
                ),
              );
            }
          },
        );
      },
    );
  }
}
