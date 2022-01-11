import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BackButton extends StatelessWidget {
  final String title;
  final String text;

  const BackButton({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.1)),
      child: Row(
        children: [
          Text(
            '$title:',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(
            width: 5,
          ),
          Text(text)
        ],
      ),
    );
  }
}
