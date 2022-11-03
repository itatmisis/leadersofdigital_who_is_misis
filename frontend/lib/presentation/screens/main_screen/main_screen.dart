import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/main_screen/widgets/plus_minus.dart';
import 'package:frontend/presentation/theme/app_colors.dart';
import 'package:frontend/presentation/widgets/search.dart';
import 'package:frontend/presentation/widgets/small_button.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          MapboxMap(
            compassEnabled: false,
            accessToken:
            'pk.eyJ1IjoicGl0dXNhbm9uaW1vdXMiLCJhIjoiY2twcHk5M2VtMDZvZjJ2bzEzMHNhNDM1diJ9.8BLcJknh8FvUVLJRZbHJDQ',
            styleString:
            'mapbox://styles/pitusanonimous/ckpq0eydh0tk318mr0dcw773k',
            initialCameraPosition: const CameraPosition(
              zoom: 12.0,
              target: LatLng(-33.86711, 151.1947171),
            ),
            onMapCreated: (MapboxMapController c) {
              controller = c;
            },
            onCameraIdle: () {
              if (onDrawed) return;
              onDrawed = true;
              controller.addFill(
                const FillOptions(
                  geometry: [
                    [
                      LatLng(-33.719, 151.150),
                      LatLng(-33.858, 151.150),
                      LatLng(-33.866, 151.401),
                      LatLng(-33.747, 151.328),
                      LatLng(-33.719, 151.150),
                    ],
                    [
                      LatLng(-33.762, 151.250),
                      LatLng(-33.827, 151.250),
                      LatLng(-33.833, 151.347),
                      LatLng(-33.762, 151.250),
                    ]
                  ],
                  fillColor: "#FF0000",
                  fillOutlineColor: "#FF0000",
                  fillOpacity: 0.3,
                ),
              );
            },
            onStyleLoadedCallback: () {},
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
                          onPlus: onCameraZoomPlus,
                          onMinus: onCameraZoomMinus),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    PointerInterceptor(
                        child: SmallButton(
                            icon: "assets/icons/layers.svg",
                            color: AppColors.neutral800,
                            onPressed: () {})),
                    const SizedBox(
                      height: 24,
                    ),
                    PointerInterceptor(
                        child: SmallButton(
                            icon: "assets/icons/settings.svg",
                            color: AppColors.neutral800,
                            onPressed: () {})),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
