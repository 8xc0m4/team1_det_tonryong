import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class WriteImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () async {
          // 1. 이미지 피커 객체 생성
          ImagePicker imagePicker = ImagePicker();
          // 2. 이미지 피커 객체의 pickImage라는 메서드 호출
          XFile? xFile = await imagePicker.pickImage(
            source: ImageSource.gallery,
          );
          print('경로 : ${xFile?.path}');
        },
        child: Container(
          margin: EdgeInsets.all(50),
          height: 300,
          width: 500,
          child: Image.asset('assets/icon/image_pick.png'),
        ),
      ),
    );
  }
}
