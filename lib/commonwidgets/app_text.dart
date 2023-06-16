import 'package:flutter/cupertino.dart';
// import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color textcolor;
  final double textsize;
  final FontWeight weight;
  final int maxline;
  const AppText({Key? key, required this.text, required this.textcolor, required this.textsize, required this.weight, this.maxline=1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: maxline,
      style: TextStyle(
        fontSize: textsize,
        fontWeight: weight,
        color: textcolor
      ),
    );
  }
}
