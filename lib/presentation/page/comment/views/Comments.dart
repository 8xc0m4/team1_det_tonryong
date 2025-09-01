import 'package:flutter/material.dart';
import 'package:team1_det_tonryong/domain/entity/comment_entity.dart';

class Comments extends StatefulWidget {
  final CommentEntity state;
  Comments({
    super.key,
    required this.state,
  });

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  bool isLike = false;

  void onChangeLike() {
    setState(() {
      if (isLike) {
        isLike = false;
        if (widget.state.commentLike > 0) {
          widget.state.commentLike - 1;
        } else {
          widget.state.commentLike = 0;
        }
      } else {
        isLike = true;
        widget.state.commentLike + 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      constraints: BoxConstraints(minHeight: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(widget.state.commentUserNM),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      // TODO: 댓글 시간 몇분 전, 몇 시간 전, 몇일전, 몇개월 전으로 표시
                      '12분 전',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.state.comment,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () {
              onChangeLike();
            },
            child: SizedBox(
              width: 50,
              height: 70,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.asset(
                      isLike
                          ? 'assets/icon/heart_pink.png'
                          : 'assets/icon/heart_brown.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    // TODO: 좋아야 수 k,m으로 표시하기
                    '${widget.state.commentLike}',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
