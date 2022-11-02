import 'package:flutter/material.dart';

class LCTButton extends StatelessWidget {
  Widget? icon;
  String text;
  Color color;

  Function() onPressed;

  LCTButton(
      {super.key,
      this.icon,
      required this.text,
      required this.onPressed,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: color),
          child: Center(
            child: icon != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        text,
                      ),
                      const SizedBox(
                        width: 34,
                      ),
                      icon!
                    ],
                  )
                : Text(text, style: TextStyle(fontSize: 22)),
          )),
    );
  }
}
