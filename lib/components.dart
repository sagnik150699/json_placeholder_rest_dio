import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();

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
          child: openSans(
            text: text,
            color: Colors.white,
            fontSize: 25.0,
          )),
    );
  }
}

class openSans extends StatelessWidget {
  final text;
  final color;
  final fontSize;
  const openSans({super.key, required this.text, this.color, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.openSans(
          fontSize: fontSize ?? 15.0, color: color ?? Colors.black),
    );
  }
}
