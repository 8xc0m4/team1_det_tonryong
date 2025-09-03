import 'package:flutter/material.dart';
import 'package:team1_det_tonryong/presentation/page/home/home_page.dart';

// 게시물 삭제 하기
class DeleteButton extends StatelessWidget {
  final VoidCallback onDelete;

  const DeleteButton({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('게시물 삭제'),
            content: const Text('정말 삭제하시겠습니까?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('취소'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
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