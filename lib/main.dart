import 'package:doctor_booking_flutter/pages/booking.dart';
import 'package:doctor_booking_flutter/pages/homepage.dart';
import 'package:doctor_booking_flutter/pages/login.dart';
import 'package:doctor_booking_flutter/pages/onboarding.dart';
import 'package:doctor_booking_flutter/pages/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUp(),
    );
  }
}
