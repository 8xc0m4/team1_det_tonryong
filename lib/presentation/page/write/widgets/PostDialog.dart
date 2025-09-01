import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:team1_det_tonryong/presentation/page/home/home_page.dart';

class PostDialog {
  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 60.0,
            vertical: 40.0,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 12.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "이사진을 게시 하겠습니까?",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 18),
                Container(
                  alignment: Alignment.centerLeft,
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: CupertinoButton(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16.0),
                        ),
                        color: Colors.transparent,
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          "취소",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 255, 0, 0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 48,
                      color: Colors.grey.shade300,
                    ),
                    Expanded(
                      child: CupertinoButton(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(16.0),
                        ),
                        color: Colors.transparent,
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => HomePage(),
                            ),
                          );
                        },
                        child: const Text(
                          "게시",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF007AFF),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
