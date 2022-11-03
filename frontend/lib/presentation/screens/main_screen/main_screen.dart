import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/main_screen/map/map_widget.dart';
import 'package:frontend/presentation/screens/main_screen/sidebar/side_bar.dart';
import 'package:frontend/presentation/screens/main_screen/topbar/topbar.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            children: [
              const Topbar(),
              Expanded(
                child: Stack(
                  children: [
                    MapWidget(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: PointerInterceptor(
                        child: SideBar(),
                      ),
                    )
                  ],
                )
              ),
            ],
          )
      ),
    );
  }
}
