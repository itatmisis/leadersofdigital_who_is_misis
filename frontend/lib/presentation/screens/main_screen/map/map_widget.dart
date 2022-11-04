import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/domain/models/area_model.dart';
import 'package:frontend/domain/models/land_model.dart';
import 'package:frontend/presentation/screens/main_screen/bloc/polygon_loader_cubit.dart';
import 'package:frontend/presentation/screens/main_screen/bloc/sidebar_cubit.dart';
import 'package:frontend/presentation/screens/main_screen/map/plus_minus.dart';
import 'package:frontend/presentation/screens/main_screen/widgets/short_menu.dart';
import 'package:frontend/presentation/theme/app_colors.dart';
import 'package:frontend/presentation/widgets/small_button.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class MapWidget extends StatefulWidget {
  MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  MapboxMapController? controller;

  bool onDrawed = false;

  OverlayEntry? shortMenu;
  bool isShortMenuActive = false;

  Fill? lastPressedPoly;
  
  @override
  void initState() {
    super.initState();
    context.read<PolygonLoaderCubit>().stream.listen((Map<int, AreaModel>? event) {
      if (controller != null) {
        if (event != null) {
          drawFills(event);
        }
      }
    });

    context.read<SidebarCubit>().stream.listen((AreaModel? event) {
      if (controller != null && event == null) {
        if (lastPressedPoly != null){
          controller!.updateFill(lastPressedPoly!,
              const FillOptions(fillColor: '#D4BDDB', fillOpacity: 0.3));

          lastPressedPoly = null;
        }
      }
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  void onCameraZoomPlus() {
    controller!.animateCamera(
        CameraUpdate.zoomTo(controller!.cameraPosition!.zoom + 1));
  }

  void onCameraZoomMinus() {
    controller!.animateCamera(
        CameraUpdate.zoomTo(controller!.cameraPosition!.zoom - 1));
  }

  void drawFills(Map<int, AreaModel> event) {
    controller!.clearFills();

    Map<int, FillOptions> mapPolygons = {};

    for (var e in event.entries) {
      mapPolygons[e.key] = FillOptions(geometry: [e.value.geometry[0]], fillColor: '#D4BDDB', fillOutlineColor: '#8B559B', fillOpacity: 0.3);
    }

    controller!.addFills(mapPolygons.values.toList());
    controller!.onFillTapped.add(onPolyPressed);
    controller!.onFeatureTapped.add((id, point, coordinates) {
      _hideShortMenu();
      _showShortMenu(point);
    });
  }

  void onPolyPressed(Fill argument) {
    if (lastPressedPoly != null) {
      controller!.updateFill(lastPressedPoly!,
          const FillOptions(fillColor: '#D4BDDB', fillOpacity: 0.3));
    }
    lastPressedPoly = argument;

    context.read<SidebarCubit>().setCurrentArea(LandModel(geometry: [[]]));
    controller!.updateFill(argument, const FillOptions(fillColor: '#8B559B', fillOpacity: 0.5));
  }

  void _showShortMenu(Point<double> click) {
    isShortMenuActive = true;

    OverlayState? overlayState = Overlay.of(context);
    shortMenu = OverlayEntry(
        builder: (_) => Positioned(
          top: click.y,
          left: click.x,
          child: PointerInterceptor(
            child: ShortMenu(),
          )
        )
    );

    overlayState.insert(shortMenu!);
  }

  void _hideShortMenu() {
    if (isShortMenuActive) {
      isShortMenuActive = false;
      shortMenu?.remove();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MapboxMap(
          cameraTargetBounds: CameraTargetBounds(LatLngBounds(
            northeast: const LatLng(56.28408249081925, 38.17401410295989),
            southwest: const LatLng(55.37949118840644, 36.75537470776375),
          )),
          compassEnabled: false,
          accessToken:
              'pk.eyJ1IjoicGl0dXNhbm9uaW1vdXMiLCJhIjoiY2twcHk5M2VtMDZvZjJ2bzEzMHNhNDM1diJ9.8BLcJknh8FvUVLJRZbHJDQ',
          styleString:
              'mapbox://styles/pitusanonimous/ckpq0eydh0tk318mr0dcw773k',
          initialCameraPosition: const CameraPosition(
            zoom: 12.0,
            target: LatLng(55.75110596550744, 37.609532416801954),
          ),
          onMapCreated: (MapboxMapController c) {
            controller = c;
          },
          onMapClick: (p, l) {
            _hideShortMenu();
            context.read<SidebarCubit>().setCurrentArea(null);
          },
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PointerInterceptor(
                  child: PlusMinusWidget(
                      onPlus: onCameraZoomPlus, onMinus: onCameraZoomMinus),
                ),
                const SizedBox(
                  height: 24,
                ),
                PointerInterceptor(
                    child: SmallButton(
                        icon: "assets/icons/straighten.svg",
                        color: AppColors.neutral800,
                        onPressed: () {})),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
