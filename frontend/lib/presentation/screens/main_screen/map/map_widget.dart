import 'dart:async';
import 'dart:math';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/data/storage/storage.dart';
import 'package:frontend/domain/models/area_model.dart';
import 'package:frontend/domain/models/capital_model.dart';
import 'package:frontend/domain/models/dot_model.dart';
import 'package:frontend/presentation/screens/main_screen/bloc/sidebar_cubit.dart';
import 'package:frontend/presentation/screens/main_screen/map/map_modes/draw_cubit.dart';
import 'package:frontend/presentation/screens/main_screen/map/map_modes/layers_state.dart';
import 'package:frontend/presentation/screens/main_screen/map/map_modes/map_cubit.dart';
import 'package:frontend/presentation/screens/main_screen/map/map_modes/map_interface.dart';
import 'package:frontend/presentation/screens/main_screen/map/map_modes/zoom_bbox_cubit.dart';
import 'package:frontend/presentation/screens/main_screen/map/plus_minus.dart';
import 'package:frontend/presentation/screens/main_screen/widgets/context_menu.dart';
import 'package:frontend/presentation/theme/app_colors.dart';
import 'package:frontend/presentation/widgets/small_button.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class FillOptionContainer {
  final FillOptions fillOptions;

  const FillOptionContainer(this.fillOptions);

  @override
  bool operator ==(Object o) {
    if (o is FillOptions &&
        o.fillColor == fillOptions.fillColor &&
        fillOptions.geometry == o.geometry) {
      return true;
    }

    if (o is FillOptionContainer &&
        o.fillOptions.fillColor == fillOptions.fillColor &&
        fillOptions.geometry == o.fillOptions.geometry) {
      return true;
    }

    return false;
  }

  @override
  // TODO: implement hashCode
  int get hashCode =>
      fillOptions.fillColor.hashCode + fillOptions.geometry.hashCode;
}

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

  Point<double>? point;

  @override
  void initState() {
    super.initState();
    
    context.read<DrawCubit>().stream.listen((event) {

      if (event.layers.length == 1 && event.layers[0] is UpdateFillLayerModel) {
        print('sdsdsd');
        UpdateFillLayerModel l = (event.layers[0] as UpdateFillLayerModel);
        controller!.updateFill(l.fill, FillOptions(fillColor: l.fillColor.toHexTriplet(), fillOutlineColor: l.outlineColor.toHexTriplet(),fillOpacity: l.opacity));
        return;
      }

      controller!.clearCircles();
      controller!.clearFills();

      for (LayerModel ev in event.layers) {
        if (ev is FillLayerModel) {
          putFillLayerOnMap(ev.event, ev.fillColor,
              ev.outlineColor, ev.onClick, ev.opacity);
        }

        if (ev is DotLayerModel) {
          controller!.addCircle(CircleOptions(geometry: ev.geometry,
              circleOpacity: ev.opacity,
              circleColor: ev.fillColor.toHexTriplet(),
              circleRadius: ev.size,
              circleStrokeColor: ev.outlineColor.toHexTriplet()));
        }

        if (ev is PolyLayerModel) {
          controller!.addFill(FillOptions(geometry: [ev.geometry],
              fillOpacity: ev.opacity,
              fillColor: ev.fillColor.toHexTriplet(),
              fillOutlineColor: ev.outlineColor.toHexTriplet()));
        }
      }
    });

    context.read<ZoomBBoxCubit>().stream.listen((event) {
      if (controller != null) {
        controller!.animateCamera(event.cameraPosition);
      }
    });
  }

  void initAfterController() {}

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

  void putFillLayerOnMap(
      Map<int, AreaModel> event, Color fillColor, Color outlineColor, Function(AreaModel, Fill) onClick,
      [double? opacity]) async {
    Map<FillOptionContainer, AreaModel> mapPolygons = {};

    for (var e in event.entries) {
      mapPolygons[FillOptionContainer(FillOptions(
          geometry: [e.value.geometry[0]],
          fillColor: fillColor.toHexTriplet(),
          fillOutlineColor: outlineColor.toHexTriplet(),
          fillOpacity: opacity ?? fillColor.opacity))] = e.value;
    }

    List l =
        await drawFills(mapPolygons.keys.toList(), fillColor, outlineColor);

    controller!.onFillTapped.add((argument) async {
      FillOptionContainer c = FillOptionContainer(argument.options);
      if (mapPolygons.containsKey(c)) {
        await Timer(Duration(milliseconds: 100), () {});
        onClick(mapPolygons[c]!, argument);
      }
    });
  }

  void putCirleLayerOnMap(Map<int, DotModel> event) async {
    List<CircleOptions> f = [];
    for (var element in event.values) {
      f.add(CircleOptions(
          circleRadius: 2,
          circleColor: AppColors.black.toHexTriplet(),
          geometry: element.location));
    }
    controller!.addCircles(f);
  }

  Future<List<Fill>> drawFills(List<FillOptionContainer> fillOptions, Color fillColor, Color outlineColor, [double? opacity]) async {
    final List<FillOptions> f = List.generate(fillOptions.length, (index) => fillOptions[index].fillOptions);
    return await controller!.addFills(f);
  }

  void _showShortMenu(Point<double> click) {
    isShortMenuActive = true;
    setState(() {});
    OverlayState? overlayState = Overlay.of(context);
    shortMenu = OverlayEntry(
        builder: (_) => Positioned(
            top: click.y,
            left: click.x,
            child: PointerInterceptor(
              child: ContextMenu(cnt: context),
            )));

    overlayState.insert(shortMenu!);
  }

  void _hideShortMenu() {
    if (isShortMenuActive) {
      isShortMenuActive = false;
      setState(() {});
      shortMenu?.remove();
    }
  }

  Function(BuildContext)? init, disposed;
  late Function(BuildContext, {PointAndLatLng? point, Annotation? annotation}) onMapPressed;
  late Function(BuildContext, CameraPosition) onCameraMove;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<MapCubit, MapInterface>(
            builder: (_, interf) {

              bool i = init == interf.init;

              init = interf.init;
              disposed = interf.dispose;
              onMapPressed = interf.onMapPressed;
              onCameraMove = interf.onCameraMove;

              if (controller != null && !i) {
                init!(context);
              }

              return BlocBuilder<ZoomBBoxCubit, ZoomBBoxState>(
                  builder: (_, st) => MapboxMap(
                    cameraTargetBounds: CameraTargetBounds(LatLngBounds(
                      northeast: st.rt,
                      southwest: st.lb,
                    )),
                    compassEnabled: false,
                    zoomGesturesEnabled: st.isScroll,
                    scrollGesturesEnabled: st.isScroll,
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

                      controller!.onFeatureTapped.add((id, p, coordinates) {
                        point = p;
                        onMapPressed(context, point: PointAndLatLng(p, coordinates));
                      });

                      init!(context);
                    },
                    onMapClick: (p, l) {
                      _hideShortMenu();
                      onMapPressed(context, point: PointAndLatLng(p, l));
                    },

                    onCameraIdle: () =>
                        onCameraMove(context, controller!.cameraPosition!),
                  )
              );
            }
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
