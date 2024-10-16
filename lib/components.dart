import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonNav extends StatelessWidget {
  final page;
  final String text;
  const ButtonNav({super.key, required this.page, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 25.0, right: 25.0),
      child: MaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        elevation: 10.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        height: 70.0,
        color: Colors.black87,
        child: Text(
          text,
          style: GoogleFonts.alata(fontSize: 25.0, color: Colors.white),
        ),
      ),
    );
  }
}
