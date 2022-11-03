import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/main_screen/topbar/tab_button.dart';
import 'package:frontend/presentation/theme/app_colors.dart';
import 'package:frontend/presentation/widgets/search.dart';

class Topbar extends StatelessWidget {


  const Topbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: AppColors.neutral800,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Flexible(child: TabButton(icon: 'assets/icons/menu.svg', text: 'Меню', iconSize: 15, topPadding: 12,)),
                VerticalDivider(indent: 10, endIndent: 10, color: AppColors.neutral400, width: 1,),
                SizedBox(width: 20,),
                Search.v1()
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                VerticalDivider(indent: 10, endIndent: 10, color: AppColors.neutral400, width: 1,),
                Flexible(child: TabButton(icon: 'assets/icons/layers.svg', text: 'Слои')),
                Flexible(child: TabButton(icon: 'assets/icons/configurator.svg', text: 'Конфигуратор')),
                Flexible(child: TabButton(icon: 'assets/icons/import.svg', text: 'Импорт')),
                Flexible(child: TabButton(icon: 'assets/icons/export.svg', text: 'Экспорт')),
              ],
            ),
          )
        ],
      ),
    );
  }

}