import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'display_picture_screen.dart';
import '../widgets/filter_selector.dart';

class LiveFilterCameraScreen extends StatefulWidget {
  const LiveFilterCameraScreen({super.key, required this.camera});
  final CameraDescription camera;

  @override
  State<LiveFilterCameraScreen> createState() => _LiveFilterCameraScreenState();
}

class _LiveFilterCameraScreenState extends State<LiveFilterCameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  final _filters = [
    Colors.white,
    ...List.generate(
      Colors.primaries.length,
      (index) => Colors.primaries[(index * 4) % Colors.primaries.length],
    )
  ];
  final _filterColor = ValueNotifier<Color>(Colors.white);

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    _filterColor.dispose();
    super.dispose();
  }

  void _onFilterChanged(Color value) {
    _filterColor.value = value;
  }

  void _onTakePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();
      final selectedColor = _filterColor.value;

      if (!context.mounted) return;

      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DisplayPictureScreen(
            imagePath: image.path,
            appliedFilterColor: selectedColor,
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_controller);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          _buildFilterOverlay(),
          _buildFilterUI(),
        ],
      ),
    );
  }

  Widget _buildFilterOverlay() {
    return ValueListenableBuilder(
      valueListenable: _filterColor,
      builder: (context, color, child) {
        if (color == Colors.white) {
          return const SizedBox.shrink();
        }

        return Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: color.withOpacity(0.5),
              backgroundBlendMode: BlendMode.color,
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterUI() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Container(
            height: 180,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black54,
                  Colors.black87,
                ],
              ),
            ),
            child: SizedBox(
              height: 150,
              child: FilterSelector(
                onFilterChanged: _onFilterChanged,
                filters: _filters,
                onTakePicture: _onTakePicture,
              ),
            ),
          ),
        ],
      ),
    );
  }
}