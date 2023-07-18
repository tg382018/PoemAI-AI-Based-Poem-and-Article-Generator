import 'package:flutter/material.dart';

class GlowingButton extends StatefulWidget {
  const GlowingButton({Key? key}) : super(key: key);

  @override
  State<GlowingButton> createState() => _GlowingButtonState();
}

class _GlowingButtonState extends State<GlowingButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Create',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
            ),
          ],
        ),
        duration: Duration(microseconds: 222),
        height: 48,
        width: 160,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(44),
            gradient: LinearGradient(colors: [
              Colors.pinkAccent,
              Colors.indigoAccent,
            ]),
            boxShadow: [
              BoxShadow(
                  color: Colors.pinkAccent.withOpacity(.6),
                  spreadRadius: 1,
                  blurRadius: 16,
                  offset: Offset(-8, 8)),
              BoxShadow(
                  color: Colors.indigoAccent.withOpacity(.2),
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: Offset(-8, 0)),
              BoxShadow(
                  color: Colors.indigoAccent.withOpacity(.2),
                  spreadRadius: 5,
                  blurRadius: 32,
                  offset: Offset(-8, 0))
            ]));
  }
}
