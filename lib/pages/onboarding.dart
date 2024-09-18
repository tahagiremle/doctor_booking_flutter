import 'package:doctor_booking_flutter/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF86A8E7),
      body: Container(
        margin: const EdgeInsets.only(top: 120),
        child: Column(
          children: [
            Container(
              child: Text(
                "HeartWise",
                style: GoogleFonts.nunito(
                    fontSize: 55, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 50),
            Image.asset(
              "assets/doctors2.png",
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.only(
                right: 15,
                left: 40,
              ),
              child: const Text(
                "Experience personalized care with the convenience of online booking. Whether it's a routine checkup or a detailed consultation, booking your appointment has never been easier. Manage your health with just a few taps!",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 222, 229, 212),
                    borderRadius: BorderRadius.circular(20)),
                child: const Text(
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
