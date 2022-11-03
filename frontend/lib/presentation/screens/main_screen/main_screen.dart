import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/main_screen/map/map_widget.dart';
import 'package:frontend/presentation/screens/main_screen/topbar/topbar.dart';

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
              Expanded(child: MapWidget()),
            ],
          )
      ),
    );
  }
}
