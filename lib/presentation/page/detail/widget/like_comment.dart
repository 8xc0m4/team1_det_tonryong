import 'package:flutter/material.dart';

// 좋아요 버튼 활성화 및 댓글 페이지 연결 예정
class LikeComment extends StatefulWidget {
  const LikeComment({super.key});

  @override
  State<StatefulWidget> createState() => _LikeCommentState();
}

class _LikeCommentState extends State<LikeComment> {
  bool liked = false;

  void _toggleLike() {
    setState(() {
      liked = !liked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: _toggleLike, // 다른 곳에서 좋아요 누르면 올라간 숫자 유지 // 좋아요 누르면 숫자 올라가게 만들기
          child: Image.asset(
            liked
                ? 'assets/icon/heart_pink.png'
                : 'assets/icon/heart_brown.png',
            width: 40,
            height: 40,
          ),
        ),
        const SizedBox(height: 15),
        Image.asset(
          'assets/icon/dg.png',
          width: 40,
          height: 40,
        ),
      ],
    );
  }
}
