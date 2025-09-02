import 'package:flutter/material.dart';
import 'package:team1_det_tonryong/presentation/page/write/widgets/write_image.dart';

class WritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              'assets/icon/appbar_logo.png',
            ),
            SizedBox(width: 30),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset('assets/icon/pen2.png'),
            ),
          ],
        ),
      ),
      body: WriteImage(),
    );
  }
}
