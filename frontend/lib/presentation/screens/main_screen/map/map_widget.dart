import 'package:flutter/material.dart';
import 'package:frontend/data/api/api.dart';
import 'package:frontend/presentation/screens/main_screen/map/plus_minus.dart';
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
  late MapboxMapController controller;

  bool onDrawed = false;

  void onCameraZoomPlus() {
    controller.animateCamera(
        CameraUpdate.zoomTo(controller.cameraPosition!.zoom + 1));
  }

  void onCameraZoomMinus() {
    controller.animateCamera(
        CameraUpdate.zoomTo(controller.cameraPosition!.zoom - 1));
  }

  void drawPolygonsFromServer() async {
    final polygons = await Api().getPolygons();

    Map<int, FillOptions> mapPolygons = {};

    //late LatLng l;
    for (var p in polygons) {
      List<LatLng> geometry = [];
      for (var g in p['polygons'][0]) {
        //l = LatLng(g[0], g[1]);
        geometry.add(LatLng(g[0], g[1]));
      }
      mapPolygons[p['oid']] = FillOptions(geometry: [geometry], fillColor: '#8B559B', fillOutlineColor: '#8B559B', fillOpacity: 0.7);
    }
    //controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: l, zoom: 15)));
    controller.addFills(mapPolygons.values.toList());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MapboxMap(
          cameraTargetBounds: CameraTargetBounds(LatLngBounds(
            northeast: LatLng(56.28408249081925, 38.17401410295989),
            southwest: LatLng(55.37949118840644, 36.75537470776375),
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

          onStyleLoadedCallback: () {
            drawPolygonsFromServer();
          },
        ),
        Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 10),
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
            )),
      ],
    );
  }
}
