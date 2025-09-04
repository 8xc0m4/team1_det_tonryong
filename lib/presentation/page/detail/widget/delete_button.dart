import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team1_det_tonryong/presentation/page/detail/view_model/detail_view_model.dart';

// 게시물 삭제 하기
class DeleteButton extends ConsumerWidget {
  final VoidCallback onDelete;
  final String feedId;
  final String userNM;

  const DeleteButton({
    super.key,
    required this.onDelete,
    required this.feedId,
    required this.userNM,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //사용자 UserNM 가져오기
    final currentuserNM =
        FirebaseAuth.instance.currentUser?.displayName; // UserNM 가죠오기
    //작성자만 삭제 버튼 보이게
    if (currentuserNM != userNM) return SizedBox.shrink();
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('게시물 삭제'),
            content: const Text('왕이 없습니다. \n정말 삭제하시겠습니까?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('취소'),
              ),

              TextButton(
                onPressed: () async {
                  await ref //
                      .read(detailViewModelProvider(feedId).notifier)
                      .deleteFeed(feedId);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('삭제'),
              ),
            ],
          ),
        );
      },
      child: Image.asset(
        'assets/icon/trash.png',
        width: 50,
        height: 50,
      ),
    );
  }
}
// 페이지 별 데이터 연결
// 파이어베이스 연결