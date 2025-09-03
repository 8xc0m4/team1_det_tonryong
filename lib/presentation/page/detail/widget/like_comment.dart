import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  ConsumerState<LikeComment> createState() => _LikeCommentState();
}

class _LikeCommentState extends ConsumerState<LikeComment> {
  bool liked = false;
  late int likeCount;
  String? currentUserNM; //현재 유저 UserNM

  @override
  void initState() {
    super.initState();
    currentUserNM =
        FirebaseAuth.instance.currentUser?.displayName; // 로그인한 UserNM 가져오기
    likeCount = widget.fLikeUsers.length;
    print('e1');
    //현재 유저가 이미 좋아요 눌렀는지 확인
    if (currentUserNM != null && widget.fLikeUsers.contains(currentUserNM)) {
      liked = true; //활성화
      print('e2');
    } // 증상 : 내 이름으로 좋아요를 누르면 유지가 됨 근데 다른 이름으로도 유지가 되있음
  }

  void _toggleLike() async {
    if (currentUserNM == null) return;
    print('e3');
    setState(() {
      liked = !liked; // 클릭 시 상태
      likeCount += liked ? 1 : -1; // 증가, 감소
    });
    print('e4');
    final docRef = FirebaseFirestore.instance
        .collection('feed')
        .doc(widget.feedId); // 피드 이름을 확인하고 현재 게시물을 선택
    print('e5');
    if (liked) {
      // 사용자가 좋아요 누르면 업데이트 해줌
      await docRef.update({
        'fLikeUsers': FieldValue.arrayUnion([currentUserNM]),
        'likeCount': FieldValue.increment(1),
      }); // 실제 현재 유저 아이디로 바꾸기
      print('e6');
    } else {
      await docRef.update({
        // 또 누르면 감소
        'fLikeUsers': FieldValue.arrayRemove([currentUserNM]),
        'likeCount': FieldValue.increment(-1),
      });
      print('e7');
    }
  }
  // 해야할 것 : 좋야요 상태 유지, 유저 아이디 사라지게 하기, 삭제 기능

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
