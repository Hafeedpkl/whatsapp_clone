import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp_clone/views/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // fontFamily: GoogleFonts.poppins().fontFamily,
        primaryColor: Color(0xFF075E54),
        primarySwatch: Colors.green,
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Color(0xFF128C7E)),
      ),
      home: HomeScreen(),
    );
  }
}
