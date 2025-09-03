import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:team1_det_tonryong/presentation/page/login/user_view_model.dart';
import 'package:team1_det_tonryong/presentation/page/home/home_page.dart';

final nickErrorProvider = StateProvider.autoDispose<String?>(
  (ref) => null,
);

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<UserCredential> login() async {
    final google = GoogleSignIn();
    final result = await google.signIn();

    final auth = await result?.authentication;
    auth?.accessToken;
    auth?.idToken;

    final cred = GoogleAuthProvider.credential(
      accessToken: auth?.accessToken,
      idToken: auth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(
      cred,
    );
  }

  @override
  Widget build(BuildContext context) {
    final userList = ref.watch(userViewModelProvider);
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/icon/dtr_logo.png'),
            SizedBox(height: 80),
            GestureDetector(
              onTap: () async {
                final user = await login();
                print(user.user?.photoURL);
                if (user.user?.uid != null) {
                  for (var i in userList) {
                    if (user.user?.uid == i.uid) {
                      if (!mounted) return;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(
                            userNickNM: i.nickNM,
                            userProfil: user.user!.photoURL!,
                          ),
                        ),
                      );
                      return;
                      //일치하는게 없으면 닉네임 다이얼로그
                    }
                  }
                  awesomeDialog(
                    context,
                    user.user!.uid,
                    user.user!.photoURL!,
                  );
                }
              },
              child: googleLogin(),
            ),
          ],
        ),
      ),
    );
  }

  AwesomeDialog awesomeDialog(
    BuildContext context,
    String uid,
    String photoURL,
  ) {
    return AwesomeDialog(
      context: context,
      width: 400,

      borderSide: BorderSide(color: Colors.black, width: 2),
      barrierColor: Colors.black26,
      dialogType: DialogType.noHeader,
      animType: AnimType.topSlide,
      alignment: Alignment.center,
      dialogBackgroundColor: Color(0xFFF1F1F1),
      dialogBorderRadius: BorderRadius.circular(20),
      buttonsBorderRadius: BorderRadius.circular(20),
      btnOkColor: Color(0xFFBABABA),
      btnOkText: '확인',
      autoDismiss: false,
      onDismissCallback: (type) {
        ref.invalidate(nickErrorProvider);
      },
      body: Center(
        child: Column(
          children: [
            Text(
              '닉네임을 입력해 주세요',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: Consumer(
                builder: (context, ref, _) {
                  final errorText = ref.watch(nickErrorProvider);
                  return TextField(
                    controller: controller,
                    onChanged: (_) {
                      // 재입력 시작하면 에러 제거
                      ref
                              .read(nickErrorProvider.notifier)
                              .state =
                          null;
                    },
                    decoration: InputDecoration(
                      errorText: errorText,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      btnOkOnPress: () async {
        // 1) 입력값
        final nick = controller.text.trim();

        // 2) 비어있음 검증
        if (nick.isEmpty) {
          ref.read(nickErrorProvider.notifier).state =
              '닉네임을 입력하세요';
          return; // 다이얼로그는 열린 채로, TextField 아래에 에러만 표시
        }

        // 3) 중복 검증 (userViewModelProvider가 List를 바로 준다고 가정)
        final users = ref.read(
          userViewModelProvider,
        ); // List<User> 라고 가정
        final isDup = users.any(
          (u) => u.nickNM.toLowerCase() == nick.toLowerCase(),
        );
        // 대소문자 무시하려면: (u) => u.nickNM.toLowerCase() == nick.toLowerCase()

        if (isDup) {
          ref.read(nickErrorProvider.notifier).state =
              '중복된 닉네임입니다';
          return; // 입력 유도
        }

        // 4) 통과 → 생성 후 이동
        ref.read(nickErrorProvider.notifier).state = null;

        await ref
            .read(userViewModelProvider.notifier)
            .createUser(
              nickNM: nick,
              uid: uid,
              photoURL: photoURL,
            );

        Navigator.of(context, rootNavigator: true).pop();

        // 다이얼로그 닫고 홈으로 이동
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomePage(
              userNickNM: controller.text,
              userProfil: photoURL,
            ),
          ),
        );
      },
    )..show();
  }

  Container googleLogin() {
    return Container(
      height: 58,
      width: 372,
      decoration: BoxDecoration(
        color: Color(0xFFBABABA),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          SizedBox(width: 25),
          Image.asset('assets/icon/google.png'),
          SizedBox(width: 35),
          Text(
            'Sign In With Google',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
