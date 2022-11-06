import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/presentation/screens/main_screen/bloc/layers_cubit.dart';
import 'package:frontend/presentation/screens/main_screen/bloc/polygon_loader_cubit.dart';
import 'package:frontend/presentation/screens/main_screen/bloc/sidebar_cubit.dart';
import 'package:frontend/presentation/screens/main_screen/main_screen.dart';
import 'package:frontend/presentation/screens/main_screen/map/map_modes/draw_cubit.dart';
import 'package:frontend/presentation/screens/main_screen/map/map_modes/heatmap_impl.dart';
import 'package:frontend/presentation/screens/main_screen/map/map_modes/layers_state.dart';
import 'package:frontend/presentation/screens/main_screen/map/map_modes/map_cubit.dart';
import 'package:frontend/presentation/screens/main_screen/map/map_modes/zoom_bbox_cubit.dart';
import 'package:frontend/presentation/screens/main_screen/topbars/cubit/top_bar_cubit.dart';
import 'package:frontend/presentation/screens/main_screen/topbars/cubit/top_bar_state.dart';
import 'package:frontend/presentation/screens/main_screen/widgets/cubit/context_menu_cubit.dart';
import 'package:frontend/presentation/theme/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.inter().fontFamily),
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => PolygonLoaderCubit(DownloadedState.none),
          ),
          BlocProvider(
            create: (_) => SidebarCubit(null),
          ),
          BlocProvider(
            create: (_) => LayersCubit([true, true, true, true, true]),
          ),
          BlocProvider(create: (_) => MapCubit(HeatMapImpl())),
          BlocProvider(create: (_) => DrawCubit(LayerState([]))),
          BlocProvider(create: (_) => ZoomBBoxCubit(ZoomBBoxState(CameraUpdate.zoomTo(14), LatLng(55.37949118840644, 36.75537470776375), LatLng(56.28408249081925, 38.17401410295989), true)))
          BlocProvider(
            create: (_) => TopBarCubit(
              ChooseTopBarState(
                  p1: LatLng(55.5, 37.5),
                  p2: LatLng(55.57, 37.57),
                  isContinueEnabled: true,
                  isBeginEnabled: false),
            ),
          ),
          BlocProvider(
            create: (_) => ContextMenuCubit(ContextMenuState.added),
          ),
        ],
        child: const MainScreen(),
      ),
    );
  }
}
