import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Booking extends StatefulWidget {
  String service;
  Booking({required this.service});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 142, 172, 205),
      body: Container(
        margin: EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Your Path to\nBetter Heart Health ",
              style: GoogleFonts.nunito(
                  color: Colors.black87,
                  fontSize: 28,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 40),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/doctors.png",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              widget.service,
              style: GoogleFonts.nunito(
                  color: Colors.black87,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(right: 15, left: 5),
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              decoration: BoxDecoration(
                  color: Color(0xFFb4817e),
                  borderRadius: BorderRadius.circular(20)),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text(
                    "Set a Date",
                    style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Icon(
                          Icons.calendar_month,
                          size: 30,
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                        style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(right: 15, left: 5),
              padding: EdgeInsets.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                  color: Color(0xFFb4817e),
                  borderRadius: BorderRadius.circular(20)),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Text(
                    "Set a Time",
                    style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _selectTime(context);
                        },
                        child: Icon(
                          Icons.alarm,
                          size: 30,
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        _selectedTime.format(context),
                        style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(right: 15, left: 5),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 254, 249, 217),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    "Book Now",
                    style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
