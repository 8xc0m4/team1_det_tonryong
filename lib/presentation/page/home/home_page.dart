import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team1_det_tonryong/notification_helper.dart';
import 'package:team1_det_tonryong/presentation/page/home/home_view_model.dart';
import 'package:team1_det_tonryong/presentation/page/home/widgets/home_list.dart';
import 'package:team1_det_tonryong/presentation/page/write/write_page.dart';

class HomePage extends ConsumerStatefulWidget {
  final String userNickNM;
  final String userProfil;
  final String uid;
  HomePage({
    required this.userNickNM,
    required this.userProfil,
    required this.uid,
  });

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    ref.read(homeViewModelProvider.notifier).changeLike(widget.userNickNM);
  }

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(homeViewModelProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              'assets/icon/dtr_pink.png',
              width: 116,
              height: 49,
            ),
            SizedBox(width: 90),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return WritePage(
                        uid: widget.uid,
                        userNM: widget.userNickNM,
                      );
                    },
                  ),
                );
              },
              child: Image.asset('assets/icon/pen2.png'),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: HomeList(
          result: result,
          userNickNM: widget.userNickNM,
          userProfil: widget.userProfil,
          uid: widget.uid,
          // result: result,
          // userNickNM: userNickNM,
          // userProfil: userProfil,
        ),
      ),
    );
  }
}
