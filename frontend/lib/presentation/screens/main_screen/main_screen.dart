import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/domain/models/area_model.dart';
import 'package:frontend/presentation/screens/main_screen/bloc/polygon_loader_cubit.dart';
import 'package:frontend/presentation/screens/main_screen/bloc/sidebar_cubit.dart';
import 'package:frontend/presentation/screens/main_screen/layers_bar/layers_bar.dart';
import 'package:frontend/presentation/screens/main_screen/widgets/loader.dart';
import 'package:frontend/presentation/screens/main_screen/map/map_widget.dart';
import 'package:frontend/presentation/screens/main_screen/topbar/topbar.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import 'sidebar/side_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PolygonLoaderCubit>().load();
    return Scaffold(
      body: Center(
          child: Stack(
        children: [
          Column(
            children: [
              const Topbar(),
              Expanded(
                child: LayoutBuilder(
                  builder: (_, c) => Stack(
                    children: [
                      MapWidget(),
                      BlocBuilder<SidebarCubit, AreaModel?>(
                        builder: (_, m) => AnimatedPositioned(
                          top: 0,
                          left: m != null ? 0 : -450,
                          height: c.maxHeight,
                          duration: const Duration(milliseconds: 200),
                          child: PointerInterceptor(
                            child: SideBar(),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: PointerInterceptor(
                          child: LayersBar(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          BlocBuilder<PolygonLoaderCubit, DownloadedState>(
              builder: (_, data) => PointerInterceptor(
                    child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 100),
                        child: data == DownloadedState.inProgress ? Loader() : const SizedBox()),
                  ))
        ],
      )),
    );
  }
}
