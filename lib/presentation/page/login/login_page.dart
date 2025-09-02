import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:team1_det_tonryong/presentation/page/home/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                //
                final user = await login();
                if (user.user?.uid != null) {
                  awesomeDialog(context);
                }
              },
              child: googleLogin(),
            ),
          ],
        ),
      ),
    );
  }

  AwesomeDialog awesomeDialog(BuildContext context) {
    return AwesomeDialog(
      context: context,
      width: 400,

      borderSide: BorderSide(color: Colors.black, width: 2),
      barrierColor: Colors.black26,
      dialogType: DialogType.noHeader,
      animType: AnimType.topSlide,
      alignment: AlignmentGeometry.center,
      dialogBackgroundColor: Color(0xFFF1F1F1),
      dialogBorderRadius: BorderRadius.circular(20),
      buttonsBorderRadius: BorderRadius.circular(20),
      btnOkColor: Color(0xFFBABABA),
      btnOkText: '확인',
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
            SizedBox(height: 50, width: 200, child: TextField()),
          ],
        ),
      ),
      btnOkOnPress: () {
        //파이어 베이스에 데이터 보낸 후 홈페이지로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomePage();
            },
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
