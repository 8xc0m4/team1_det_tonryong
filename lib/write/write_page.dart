import 'package:flutter/material.dart';

class WritePage extends StatelessWidget {
  const WritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, //배경 하얀색 지정
      appBar: AppBar(
        backgroundColor: Colors.white, //AppBar 하얀색 지정
        title: Image.asset(
          'assets/icon/appbar_logo.png',
          height: 40,
        ),

        centerTitle: true, //이미지가 AppBar 정가운데에 표시
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/icon/pen.png',
              height: 40,
            ),
          ),
        ],
      ),

      body: Stack(
        children: [
          Positioned(
            left: 150,
            top: 298,
            width: 144,
            height: 144,
            child: Image.asset(
              'assets/icon/image_pick.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
