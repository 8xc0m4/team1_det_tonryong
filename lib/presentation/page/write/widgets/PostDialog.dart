import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:team1_det_tonryong/presentation/page/home/home_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team1_det_tonryong/presentation/page/home/home_view_model.dart';

class PostDialog {
  static Future<void> show(
    BuildContext context,
    WidgetRef ref, {
    File? selectedImage,
    required BuildContext rootContext,
  }) {
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
                const Text(
                  "이사진을 게시 하겠습니까?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
                        onPressed: () async {
                          Navigator.of(context).pop(); // Close dialog

                          if (selectedImage != null) {
                            debugPrint(
                              '선택한 사진이 있습니다. 경로: ${selectedImage.path}',
                            );
                            try {
                              final storageRef = FirebaseStorage.instance.ref();
                              final fileName = DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString();
                              final imageRef = storageRef.child(
                                'posts/$fileName.jpg',
                              );
                              await imageRef.putFile(selectedImage);
                              final downloadUrl = await imageRef
                                  .getDownloadURL();

                              await FirebaseFirestore.instance
                                  .collection('posts')
                                  .add({
                                    'feedPhoto': downloadUrl,
                                    'feedTime': FieldValue.serverTimestamp(),
                                    'userNM': 'currentUserId',
                                    'feedLike': 0,
                                  });

                              ref
                                  .read(homeViewModelProvider.notifier)
                                  .addPostedPhotoUrl(downloadUrl);

                              debugPrint(
                                '게시된 사진이 Firebase에 업로드됨. URL: $downloadUrl',
                              );
                              debugPrint('로고 정보: [LOGO_PLACEHOLDER]');
                            } catch (e) {
                              debugPrint('이미지 업로드 중 오류 발생: $e');
                            }
                          } else {
                            debugPrint('선택한 사진이 없습니다.');
                          }

                          // Navigate to HomePage safely
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.of(
                              rootContext,
                              rootNavigator: true,
                            ).pushReplacement(
                              MaterialPageRoute(builder: (_) => HomePage()),
                            );
                          });
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
