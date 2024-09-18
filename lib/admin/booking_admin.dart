import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_booking_flutter/services/database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingAdmin extends StatefulWidget {
  const BookingAdmin({super.key});

  @override
  State<BookingAdmin> createState() => _BookingAdminState();
}

class _BookingAdminState extends State<BookingAdmin> {
  Stream? BookingStream;

  getontheload() async {
    BookingStream = await DatabaseMethods().getBookings();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allBookings() {
    return StreamBuilder(
        stream: BookingStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    QueryDocumentSnapshot ds = snapshot.data.docs[index];
                    return Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF91eae4),
                              Color(0xFF86a8e7),
                              Color(0xFF7f7fd5),
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/man.png",
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Name :  " + ds["Username"],
                              style: GoogleFonts.nunito(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Service :   " + ds["Service"],
                              style: GoogleFonts.nunito(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Date :   " + ds["Date"],
                              style: GoogleFonts.nunito(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Time :   " + ds["Time"],
                              style: GoogleFonts.nunito(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () async {
                                await DatabaseMethods().DeleteBookin(ds.id);
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 10, left: 20, right: 20),
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 46, 31, 35),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  "Done",
                                  style: GoogleFonts.nunito(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 60, left: 20, right: 20),
        child: Column(
          children: [
            Center(
              child: Text(
                "All Bookings",
                style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(child: allBookings()),
          ],
        ),
      ),
    );
  }
}
