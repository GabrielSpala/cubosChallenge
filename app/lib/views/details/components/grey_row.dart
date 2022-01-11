import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GreyRow extends StatelessWidget {
  final String title;
  final String text;

  const GreyRow({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(255, 241, 243, 245),
      ),
      child: Row(
        children: [
          Text(
            '$title:',
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                color: Color.fromARGB(255, 134, 142, 150),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            width: 5,
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
          )
        ],
      ),
    );
  }
}
