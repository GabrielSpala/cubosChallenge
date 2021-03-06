import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BackButton extends StatelessWidget {
  final String label;
  final Function() onTap;

  const BackButton({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.23,
            padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: const Color.fromARGB(255, 241, 243, 245),
              ),
            ),
            child: Center(
              child: Row(
                children: [
                  const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.grey,
                    size: 13,
                  ),
                  Text(
                    label,
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: Color.fromARGB(255, 134, 142, 150),
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
