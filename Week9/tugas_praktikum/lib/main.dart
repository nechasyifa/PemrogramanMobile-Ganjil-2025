import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'screens/live_filter_camera_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: LiveFilterCameraScreen(
        camera: firstCamera,
      ),
    ),
  );
}