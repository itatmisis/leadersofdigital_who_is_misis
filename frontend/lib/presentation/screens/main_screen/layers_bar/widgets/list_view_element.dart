import 'package:flutter/material.dart';
import 'package:frontend/presentation/theme/app_colors.dart';
import 'package:frontend/presentation/theme/app_fonts.dart';

class ListViewElement extends StatelessWidget {
  bool isChecked;
  void Function(bool?)? onPressed;
  Color? color;

  ListViewElement(
      {Key? key,
      required this.index,
      required this.layers,
      this.onPressed,
      required this.isChecked,
      this.color})
      : super(key: key);

  final int index;
  final List<String> layers;

  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            activeColor: AppColors.veryPeri500,
            value: isChecked,
            onChanged: onPressed),
        const SizedBox(
          width: 16,
        ),
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4), color: color),
        ),
        const SizedBox(
          width: 16,
        ),
        Flexible(child: Text(layers[index], style: AppFonts.body2Regular)),
      ],
    );
  }
}
