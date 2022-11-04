import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/presentation/screens/main_screen/sidebar/widgets/document.dart';
import 'package:frontend/presentation/screens/main_screen/sidebar/widgets/information_widget.dart';
import 'package:frontend/presentation/screens/main_screen/sidebar/widgets/purple_container_widget.dart';
import 'package:frontend/presentation/theme/app_colors.dart';
import 'package:frontend/presentation/theme/app_fonts.dart';
import 'package:flutter_svg/svg.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = [
      Criterion("Тип", "Объект недвижимости"),
      Criterion("Вид", "Земельный участок"),
      Criterion("Кадастровый квартал", "77:01:0002009"),
      Criterion("Адрес", "адресные ориентиры: Большой Толмачевский, вл 3, стр 1, 2, 5, 6"),
      Criterion("Статус", "Ранее учтенный"),
      Criterion("Категория земель","Земли населенных пунктов"),
      Criterion("Разрешенное использование","эксплуатации библиотеки",),
      Criterion("Дата внесения сведений","11.01.2022"),
    ];

    return Container(
      color: AppColors.white,
      width: 450,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("77:01:0002009:29", style: AppFonts.heading1),
                      Text("Земельный участок",
                          style:
                          AppFonts.subtitle1.copyWith(color: AppColors.gray)),
                    ],
                  ),
                  const Icon(Icons.bookmark_border_rounded, color: AppColors.black,),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: const [
                  Expanded(
                    child: PurpleContainer(
                        heading: "Площадь:", subtitle: "1184 кв.м"),
                  ),
                  SizedBox(width: 32),
                  Expanded(
                    child: PurpleContainer(heading: "Объектов:", subtitle: "3"),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              InformationWidget(data: data),
              const SizedBox(height: 40),
              Text(
                "Документы:",
                style: AppFonts.heading2,
              ),
              const SizedBox(height: 24),
              const DocumentTitle(
                title: "Планы",
              ),
              const SizedBox(height: 16),
              const DocumentTitle(
                title: "Акты обследования",
              ),
              const SizedBox(height: 16),
              const DocumentTitle(
                title: "Документ",
              ),
            ],
          ),
        )
      )
    );
  }
}
