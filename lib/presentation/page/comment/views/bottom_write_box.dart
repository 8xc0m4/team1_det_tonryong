import 'package:flutter/material.dart';

class BottomWritBox extends StatelessWidget {
  final TextEditingController textEditingController;
  final void Function({required String comment}) createComment;
  BottomWritBox({
    super.key,
    required this.textEditingController,
    required this.createComment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Color(0xffFBC3D7),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Container(
                  height: 40,
                  child: TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      hintText: '제목 추가...',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  createComment(
                    comment: textEditingController.text,
                  );
                  textEditingController.clear();
                },
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(
                    'assets/icon/send.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
