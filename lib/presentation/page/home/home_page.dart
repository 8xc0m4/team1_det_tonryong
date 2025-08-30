import 'package:flutter/material.dart';
import 'package:team1_det_tonryong/presentation/page/home/widgets/home_list.dart';
import 'package:team1_det_tonryong/presentation/page/write/write_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              'assets/icon/dtr_pink.png',
              width: 116,
              height: 49,
            ),
            SizedBox(width: 90),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return WritePage();
                    },
                  ),
                );
              },
              child: Image.asset('assets/icon/pen2.png'),
            ),
          ],
        ),
      ),
      body: HomeList(),
    );
  }
}
