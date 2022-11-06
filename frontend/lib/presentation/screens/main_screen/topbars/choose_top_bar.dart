import 'package:flutter/material.dart';
import 'package:frontend/presentation/theme/app_colors.dart';
import 'package:frontend/presentation/theme/app_fonts.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class ChooseTopBar extends StatelessWidget {
  ChooseTopBar({Key? key, required List<LatLng> points}) : super(key: key) {
    point = points;
  }

  int tappedPoints = 0;
  late List<LatLng>? point;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: AppColors.neutral800,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Вы выбрали точку 1 ${point![0].latitude} ${point![0].longitude}"),
              Text(
                  "Вы выбрали точку 2 ${point![1].latitude} ${point![1].longitude}"),
            ],
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4), color: AppColors.white),
            child: (tappedPoints == 2)
                ? TextButton(
                    onPressed: () {},
                    child: const Text("Начать"),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
