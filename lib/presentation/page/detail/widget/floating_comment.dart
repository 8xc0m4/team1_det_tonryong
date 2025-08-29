import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

// 랜덤위치 댓글 기능
class FloatingCommentManager extends StatefulWidget {
  const FloatingCommentManager({super.key});

  @override
  State<FloatingCommentManager> createState() => _FloatingCommentManagerState();
}

class _FloatingCommentManagerState extends State<FloatingCommentManager> {
  final List<String> comments = [
    // 댓글 샘플
    '진도 이만큼 남았어요!',
    '형은 다 알 수가 있다니깐.',
    '두피에도 때를 미나요? 라고 질문한 놈 나와.',
  ];

  // 현재 화면에 댓글리스트 표시
  final List<_FloatingComment> activeComments = [];
  final Random random = Random(); // 랜덤 표시

  @override
  void initState() {
    super.initState();
    _startCommentSpawner();
  }

  void _startCommentSpawner() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      //2초마다 댓글생성
      if (!mounted) return;

      //화면 밖에 안빠져 나가게 하기
      final screenWidth = MediaQuery.of(context).size.width;
      // final screenHeight = MediaQuery.of(context).size.height;

      final randomX = random.nextDouble() * (screenWidth);
      final randomY = random.nextDouble() * (250.0); // 여기가 범인

      setState(() {
        // print('Qnd');
        activeComments.add(
          _FloatingComment(
            text: comments[random.nextInt(comments.length)],
            startX: randomX,
            startY: randomY,
            key: UniqueKey(), //중복 방지
          ),
        );
        // print('comments[random.nextInt(comments.length)]');
        // print('startX : $randomX');

        // print('startY : $randomY');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      // 댓글리스트를 스택으로 만들기
      children: activeComments,
    );
  }
}

class _FloatingComment extends StatefulWidget {
  final String text;
  final double startX;
  final double startY;

  const _FloatingComment({
    required this.text,
    required this.startX,
    required this.startY,
    super.key,
  });

  @override
  State<_FloatingComment> createState() => _FloatingCommentState();
}

class _FloatingCommentState extends State<_FloatingComment>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _positionY;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), //3초동안 애니메이션
    )..forward();

    //투명도
    _opacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _positionY = Tween<double>(begin: 0, end: 100).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (mounted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              final parentState = context
                  .findAncestorStateOfType<_FloatingCommentManagerState>();
              parentState?.setState(() {
                parentState.activeComments.remove(widget);
              });
            }
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    const int maxTextLine = 15;
    final text = widget.text;
    final displayText = (text.length > maxTextLine)
        ? '${text.substring(0, maxTextLine)}\n${text.substring(maxTextLine)}'
        : text;

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Positioned(
          // 왜 자꾸 화면을 빠져나갈까
          left: widget.startX.clamp(0, screenWidth),
          bottom: widget.startY + _positionY.value,
          child: Opacity(
            opacity: _opacity.value,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 10,
                maxWidth: 400,
                minHeight: 10,
                maxHeight: 300,
              ),
              child: Text(
                displayText, //예시 택스트 가져오기
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
