//export 1 dominant color from image url
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:http/http.dart' as http;

Future<Color> exportDominantColor(String imageUrl) async {
  final response = await http.get(Uri.parse(imageUrl));
  final imageProvider = MemoryImage(response.bodyBytes);
  final paletteGenerator = await PaletteGenerator.fromImageProvider(
    imageProvider,
    size: Size(100, 100),
    maximumColorCount: 1,
  );
  return paletteGenerator.dominantColor?.color ?? Colors.white;
}
