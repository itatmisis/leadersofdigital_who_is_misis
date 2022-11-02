import 'package:flutter/material.dart';
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
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  late MapboxMapController controller;
  bool onDrawed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: MapboxMap(
        accessToken:
            'pk.eyJ1IjoicGl0dXNhbm9uaW1vdXMiLCJhIjoiY2twcHk5M2VtMDZvZjJ2bzEzMHNhNDM1diJ9.8BLcJknh8FvUVLJRZbHJDQ',
        styleString: 'mapbox://styles/pitusanonimous/ckpq0eydh0tk318mr0dcw773k',
        initialCameraPosition: CameraPosition(
          zoom: 12.0,
          target: LatLng(-33.86711, 151.1947171),
        ),
        onMapCreated: (MapboxMapController c) {
          controller = c;
        },
            onCameraIdle: () {
          if (onDrawed) return;
          onDrawed = true;
              controller.addFill(FillOptions(
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
              )).then((value) => controller.removeFill(value));
            },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
