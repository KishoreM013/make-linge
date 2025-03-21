import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class ImageUtils {
  static Future<Uint8List> getImageFromNetwork(String url) async {
    final response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }

  static Future<Uint8List> getImageFromAssets(String path) async {
    final response = await rootBundle.load(path);
    return response.buffer.asUint8List();
  }

  static Future<Uint8List> getImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    return image!.readAsBytes();
  }
  
  static Future<Uint8List> getImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    return image!.readAsBytes();
  }
}
