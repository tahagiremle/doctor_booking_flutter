import 'package:doctor_booking_flutter/pages/homepage.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 142, 172, 205),
      body: Container(
        margin: EdgeInsets.only(top: 120),
        child: Column(
          children: [
            Image.asset(
              "assets/doctors.png",
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(
                right: 15,
                left: 40,
              ),
              child: Text(
                "Experience personalized care with the convenience of online booking. Whether it's a routine checkup or a detailed consultation, booking your appointment has never been easier. Manage your health with just a few taps!",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 222, 229, 212),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "Expert Doctor Just a Tap Away",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
