import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/main_screen/main_screen.dart';

import 'widgets/topbar.dart';

class TopbarScreen extends StatefulWidget {
  const TopbarScreen({super.key});

  @override
  State<TopbarScreen> createState() => _TopbarScreenState();
}

class _TopbarScreenState extends State<TopbarScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Topbar(onTap: () {},),
          Expanded(child: MainScreen())
        ],
      ),
    );
  }
}