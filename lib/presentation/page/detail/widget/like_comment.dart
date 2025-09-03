import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team1_det_tonryong/domain/entity/home_entity.dart';
import 'package:team1_det_tonryong/presentation/page/comment/comment_page.dart';
import 'package:team1_det_tonryong/presentation/page/detail/view_model/detail_view_model.dart';

// 좋아요 버튼 활성화 및 댓글 페이지 연결 예정
class LikeComment extends ConsumerStatefulWidget {
  final int feedLike;
  final String feedId;
  final String userNickNM;
  final String userProfil;
  final List<String> fLikeUsers;
  const LikeComment({
    super.key,
    required this.feedLike,
    required this.fLikeUsers,
    required this.feedId,
    required this.userNickNM,
    required this.userProfil,
  });

  @override
  ConsumerState<LikeComment> createState() => _LikeCommentState();
}

class _LikeCommentState extends ConsumerState<LikeComment> {
  late bool liked;
  late int likeCount;
  //현재 유저 UserNM

  @override
  void initState() {
    ref.read(detailViewModelProvider(widget.feedId));
    _syncLike();
    super.initState();
  }

  void _syncLike() {
    liked = widget.fLikeUsers.contains(
      widget.userNickNM,
    ); //현재 유저가 이미 좋아요 눌렀는지 확인
    likeCount = widget.fLikeUsers.length; //값을 정해줌
  }

  @override
  void didUpdateWidget(covariant LikeComment oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.feedLike != widget.feedLike) {
      _syncLike();
      setState(() {});
    }
  }

  void _toggleLike() async {
    setState(() {
      liked = !liked; // 클릭 시 상태
      likeCount += liked ? 1 : -1; // 증가, 감소
      ref
          .read(detailViewModelProvider(widget.feedId).notifier)
          .feedLikeUpdate(
            feedId: widget.feedId,
            liked: liked,
            userNM: widget.userNickNM,
          );
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
// 좋아요와 유지되지 않고 삭제가 실시간 반영이 안됨 