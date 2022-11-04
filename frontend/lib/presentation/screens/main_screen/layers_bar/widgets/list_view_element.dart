import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/main_screen/map/map_widget.dart';
import 'package:frontend/presentation/theme/app_colors.dart';
class ListViewElement extends StatefulWidget {
  const ListViewElement({Key? key, required this.index, required this.layers}) : super(key: key);

  final int index;
  final List<String> layers;

  @override
  State<ListViewElement> createState() => _ListViewElementState();
}

class _ListViewElementState extends State<ListViewElement> {
  bool isChecked=true;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          activeColor: AppColors.veryPeri500,
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value!;

            });
          },
        ),
        const SizedBox(
          width: 16,
        ),
        Text(widget.layers[widget.index]),
      ],
    );;
  }
}
