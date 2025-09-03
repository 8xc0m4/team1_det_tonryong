import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team1_det_tonryong/presentation/page/comment/comment_page.dart';

// 좋아요 버튼 활성화 및 댓글 페이지 연결 예정
class LikeComment extends ConsumerStatefulWidget {
  final String feedId;
  final String userNickNM;
  final String userProfil;
  final List<String> fLikeUsers;
  const LikeComment({
    super.key,
    required this.fLikeUsers,
    required this.feedId,
    required this.userNickNM,
    required this.userProfil,
  });

  @override
  ConsumerState<LikeComment> createState() =>
      _LikeCommentState();
}

class _LikeCommentState extends ConsumerState<LikeComment> {
  bool liked = false;
  late int likeCount;

  @override
  void initState() {
    super.initState();
    likeCount = widget.fLikeUsers.length;
  }

  void _toggleLike() {
    setState(() {
      liked = !liked;
      likeCount += liked ? 1 : -1;

      if (liked) {
        widget.fLikeUsers.add("fLikeUsers"); // 실제 현재 유저 아이디로 바꾸기
      } else {
        widget.fLikeUsers.remove("fLikeUsers");
      }
    }); //좋아요 숫자 증가
  }
  // 좋야요 상태 유지, 유저 아이디 사라지게 하기, 삭제 기능

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap:
              _toggleLike, // 다른 곳에서 좋아요 누르면 올라간 숫자 유지 // 좋아요 누르면 숫자 올라가게 만들기
          child: Image.asset(
            liked
                ? 'assets/icon/heart_pink.png'
                : 'assets/icon/heart_brown.png',
            width: 40,
            height: 40,
          ),
        ),
        Text('$likeCount'),
        const SizedBox(height: 15),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return CommentPage(
                    feedId: widget.feedId,
                    userNM: widget.userNickNM,
                    userProfil: widget.userProfil,
                  );
                },
              ),
            );
          },
          child: Image.asset(
            'assets/icon/dg.png',
            width: 40,
            height: 40,
          ),
        ),
      ],
    );
  }
}
