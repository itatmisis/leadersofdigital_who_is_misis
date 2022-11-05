import 'package:flutter/material.dart';
import 'package:frontend/presentation/theme/app_colors.dart';
class ListViewElement extends StatelessWidget {

  bool isChecked;
  void Function(bool?)? onPressed;

  ListViewElement({Key? key, required this.index, required this.layers, this.onPressed, required this.isChecked}) : super(key: key);

  final int index;
  final List<String> layers;

  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          activeColor: AppColors.veryPeri500,
          value: isChecked,
          onChanged: onPressed
        ),
        const SizedBox(
          width: 16,
        ),
        Text(layers[index]),
      ],
    );
  }

}

