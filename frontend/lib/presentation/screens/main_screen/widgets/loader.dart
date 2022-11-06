import 'package:flutter/material.dart';
import 'package:frontend/presentation/theme/app_colors.dart';
import 'package:frontend/presentation/theme/app_fonts.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0x62000000),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: AppColors.dewberry400),
            SizedBox(height: 10,),
            Text('Загрузка географических данных', style: AppFonts.body1Regular.copyWith(color: AppColors.white),)
          ],
        )
      ),
    );
  }

}