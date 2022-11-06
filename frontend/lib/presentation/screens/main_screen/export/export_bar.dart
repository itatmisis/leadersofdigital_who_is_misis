import 'package:flutter/material.dart';
import 'package:frontend/presentation/theme/app_colors.dart';

class ExportBar extends StatelessWidget {
  const ExportBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: Container(
        height: MediaQuery.of(context).size.height-60,
        color: AppColors.white,
        width: 300,
        child: Image.asset("assets/images/export.png"),
      ),
    );
  }
}
