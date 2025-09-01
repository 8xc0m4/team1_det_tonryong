import 'package:flutter/material.dart';

class EmptyComment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(
            flex: 3,
          ),
          SizedBox(
            width: 120,
            child: Image.asset(
              'assets/icon/empty_logo.png',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '제목이 없습니다.\n제목을 지어주세요!',
            style: TextStyle(
              fontSize: 24,
              color: Color(0xffE9DDD9),
            ),
            textAlign: TextAlign.center,
          ),
          Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  }
}
