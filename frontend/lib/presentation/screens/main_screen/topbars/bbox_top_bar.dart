import 'package:flutter/material.dart';
import 'package:frontend/presentation/theme/app_colors.dart';
import 'package:frontend/presentation/widgets/search.dart';

import 'tab_button.dart';

class BboxTopBar extends StatelessWidget {
  const BboxTopBar({Key? key, this.currentRightPage, this.onRightMenuPressed})
      : super(key: key);
  final int? currentRightPage;
  final void Function(int)? onRightMenuPressed;

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
                Flexible(
                    child: TabButton(
                  icon: 'assets/icons/menu.svg',
                  text: 'Меню',
                  iconSize: 15,
                  topPadding: 12,
                )),
                VerticalDivider(
                  indent: 10,
                  endIndent: 10,
                  color: AppColors.neutral400,
                  width: 1,
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                VerticalDivider(
                  indent: 10,
                  endIndent: 10,
                  color: AppColors.neutral400,
                  width: 1,
                ),
                Flexible(
                    child: TabButton(
                        icon: 'assets/icons/layers.svg',
                        text: 'Слои',
                        isActive: currentRightPage == 0 ? true : false,
                        onPressed: () {
                          if (onRightMenuPressed != null)
                            onRightMenuPressed!(0);
                        })),
                Flexible(
                    child: TabButton(
                        icon: 'assets/icons/configurator.svg',
                        text: 'Конфигуратор',
                        isActive: currentRightPage == 1 ? true : false,
                        onPressed: () {
                          if (onRightMenuPressed != null)
                            onRightMenuPressed!(1);
                        })),
                Flexible(
                    child: TabButton(
                        icon: 'assets/icons/import.svg',
                        text: 'Импорт',
                        isActive: currentRightPage == 2 ? true : false,
                        onPressed: () {
                          if (onRightMenuPressed != null)
                            onRightMenuPressed!(2);
                        })),
                Flexible(
                    child: TabButton(
                        icon: 'assets/icons/export.svg',
                        text: 'Экспорт',
                        isActive: currentRightPage == 3 ? true : false,
                        onPressed: () {
                          if (onRightMenuPressed != null)
                            onRightMenuPressed!(3);
                        })),
              ],
            ),
          )
        ],
      ),
    );
  }
}
