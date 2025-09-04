import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team1_det_tonryong/data/dto/feed_dto.dart';
import 'package:team1_det_tonryong/firebase_options.dart';
import 'package:team1_det_tonryong/presentation/page/detail/detail_page.dart';
import 'package:team1_det_tonryong/presentation/page/welcome/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: WelcomePage(),
      home: WelcomePage(),
    );
  }
}

// FeedDto test = FeedDto(
//   feedId: 'fu7Wtfzxo2c4urwd2aNT',
//   userNM: 'dltkdfhr',
//   feedTime: DateTime.now(),
//   feedLike: 4,
//   feedPhoto: 'assets/icon/hansukwon.png',
//   fLikeUsers: ['이상록', '김현수', '노서연', '임우형'],
// );

// 문제 : 베스트 댓글이 적용 안됌
// 피드 좋아요 적용 안됌
