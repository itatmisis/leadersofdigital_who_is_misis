import 'package:flutter/material.dart';
import 'package:frontend/presentation/theme/app_colors.dart';
import 'package:frontend/presentation/theme/app_fonts.dart';

class Criterion {
  final String key;
  final String value;

  Criterion(this.key, this.value);
}

class InformationWidget extends StatelessWidget {
  const InformationWidget({Key? key, required this.data}) : super(key: key);

  final List<Criterion> data;

  @override
  Widget build(BuildContext context) {


    Widget _listItem(int index) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 11,horizontal: 16),
        decoration: BoxDecoration(
            border: (index != data.length - 1)
                ? const Border(
                    bottom: BorderSide(width: 1, color: AppColors.lightGray))
                : null),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${data[index].key}:",
              style: AppFonts.body2Regular.copyWith(color: AppColors.gray),
            ),
            const SizedBox(
              width: 24,
            ),
            Flexible(
                child: Text(
              data[index].value,
              style: AppFonts.body2Medium,
            )),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightGray),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.veryPeri200,
                    border: Border(
                      bottom:
                          BorderSide(width: 1, color: AppColors.lightGray),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    child: Center(
                      child: Text(
                        "Информация",
                        style: AppFonts.body1SemiBold,
                      ),
                    ),
                  ),
                ),
                _listItem(index)
              ],
            );
          }
          return _listItem(index);
        },
      ),
    );
  }
}
