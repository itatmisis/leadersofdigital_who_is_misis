import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/presentation/screens/main_screen/widgets/cubit/context_menu_cubit.dart';
import 'package:frontend/presentation/theme/app_colors.dart';
import 'package:frontend/presentation/theme/app_fonts.dart';

class ContextMenu extends StatelessWidget {
   ContextMenu({super.key, required this.cnt});
  BuildContext cnt;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius:BorderRadius.circular(8) ,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: ()=>cnt.read<ContextMenuCubit>().tapAdd(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.done,
                      color: AppColors.veryPeri500,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text("Включить объект",
                        style: AppFonts.body2Medium
                            .copyWith(color: AppColors.veryPeri500)),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: ()=>cnt.read<ContextMenuCubit>().tapConsider(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.contact_support,
                      color: AppColors.veryPeri500,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text("На рассмотрение",
                        style: AppFonts.body2Medium
                            .copyWith(color: AppColors.veryPeri500)),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: ()=>cnt.read<ContextMenuCubit>().tapDelete(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.close,
                      color: AppColors.veryPeri500,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text("Исключить объект",
                        style: AppFonts.body2Medium
                            .copyWith(color: AppColors.veryPeri500)),
                  ],
                ),
              ),
            ),
            const Divider(
              color: AppColors.gray,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Изменить",
                    style: AppFonts.body2Regular,
                  ),
                  const Icon(
                    Icons.edit_location_alt_rounded,
                    color: AppColors.black,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Удалить",
                    style: AppFonts.body2Regular,
                  ),
                  const Icon(
                    Icons.done,
                    color: AppColors.black,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Добавить объект",
                    style: AppFonts.body2Regular,
                  ),
                  const Icon(
                    Icons.add_location_alt,
                    color: AppColors.black,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
