import 'package:flutter/material.dart';
import 'package:team1_det_tonryong/data/dto/feed_dto.dart';
import 'package:team1_det_tonryong/presentation/page/detail/widget/delete_button.dart';
import 'package:team1_det_tonryong/presentation/page/detail/widget/floating_comment.dart';
import 'package:team1_det_tonryong/presentation/page/detail/widget/like_comment.dart';
import 'package:team1_det_tonryong/presentation/page/home/home_page.dart';

class DetailPage extends StatelessWidget {
  final FeedDto feed; //null 다시 확인
  const DetailPage({super.key, required this.feed});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/icon/appbar_logo.png'),
        centerTitle: true,
        actions: [
          DeleteButton(
            onDelete: () {
              Text('삭제됨'); // 작성자만 보이게 만들기
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              ); // 삭제하고 홈페이지로 이동 구현하기
            },
          ),
        ],
      ),

      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  feed.userNM, // 임시 사용자 이름
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(feed.feedTime.toString()), // 임시 날짜
              ],
            ),
          ),
          Image.asset(
            'assets/icon/hansukwon.png',
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ), // 임시이미지
          SizedBox(height: 5),
          Text(
            '누가 수능 날 수업 들으러 오래!!',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.all(5),
            width: 400,
            height: 300,
            color: Color(0xfff1f1f1),
            child: Stack(
              children: [
                const FloatingCommentManager(
                  commentId: '',
                ), // 댓글 표시
                Positioned(
                  //하트, 댓글 아이콘 위치
                  right: 10,
                  top: 100,
                  child: LikeComment(feed: feed),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
