import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Picker extends StatefulWidget {
  const Picker({super.key});

  static Future<File?> show(BuildContext context) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      debugPrint('이미지 선택 중 오류 발생: $e');
    }
    return null;
  }

  @override
  State<Picker> createState() => _PickerPageState();
}

class _PickerPageState extends State<Picker> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
