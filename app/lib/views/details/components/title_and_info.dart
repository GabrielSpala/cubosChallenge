import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleAndInfo extends StatelessWidget {
  final String title;
  final String text;

  const TitleAndInfo({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.05,
              bottom: MediaQuery.of(context).size.height * 0.01),
          child: Row(
            children: [
              Text(
                title,
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    color: Color.fromARGB(255, 134, 142, 150),
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          text,
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              color: Color.fromARGB(255, 52, 58, 64),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
