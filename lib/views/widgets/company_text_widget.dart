import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CompanyLogoText extends StatelessWidget {
  final Color? firstColor;
  final Color? secondColor;
  final double? fontSize1;
  final double? fontSize2;
  final bool center;

  const CompanyLogoText({
    Key? key,
    this.firstColor,
    this.secondColor,
    this.fontSize1,
    this.fontSize2,
    this.center = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment:
            center ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Text(
            'Nix',
            style: GoogleFonts.carterOne(
              textStyle: TextStyle(
                color:
                    firstColor ?? Theme.of(context).textTheme.subtitle1!.color,
                fontSize: fontSize1 ?? 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            'Lab',
            style: GoogleFonts.carterOne(
              textStyle: TextStyle(
                color:
                    secondColor ?? Theme.of(context).textTheme.subtitle1!.color,
                fontSize: fontSize2 ?? 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
