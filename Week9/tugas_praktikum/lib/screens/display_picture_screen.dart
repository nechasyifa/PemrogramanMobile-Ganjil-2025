import 'dart:io';
import 'package:flutter/material.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final Color appliedFilterColor;

  const DisplayPictureScreen({
    super.key,
    required this.imagePath,
    required this.appliedFilterColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hasil Foto dengan Filter')),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(
            File(imagePath),
            fit: BoxFit.cover, 
          ),

          if (appliedFilterColor != Colors.white)
            Container(
              decoration: BoxDecoration(
                color: appliedFilterColor.withOpacity(0.5),
                backgroundBlendMode: BlendMode.color,
              ),
            ),
        ],
      ),
    );
  }
}