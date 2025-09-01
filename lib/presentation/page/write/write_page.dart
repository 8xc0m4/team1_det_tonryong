import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team1_det_tonryong/presentation/page/write/widgets/album.dart';
import 'package:team1_det_tonryong/presentation/page/write/widgets/picker.dart';
import 'package:team1_det_tonryong/presentation/page/write/widgets/postdialog.dart';
import 'package:photo_manager/photo_manager.dart';

class WritePage extends ConsumerStatefulWidget {
  const WritePage({super.key});

  @override
  ConsumerState<WritePage> createState() => _WritePageState();
}

class _WritePageState extends ConsumerState<WritePage> {
  File? _selectedImage;
  List<File> _allGalleryPhotos = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadGalleryPhotos();
    });
  }

  Future<void> _loadGalleryPhotos() async {
    try {
      final permission = await PhotoManager.requestPermissionExtend();
      if (!permission.isAuth) return;

      final albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
      );
      if (albums.isEmpty) return;

      final assets = await albums[0].getAssetListPaged(page: 0, size: 5);
      final files = <File>[];
      for (var asset in assets) {
        final file = await asset.file;
        if (file != null) files.add(file);
      }

      setState(() {
        _allGalleryPhotos = files.reversed.toList();
      });
    } catch (e) {
      debugPrint('갤러리 로딩 중 오류 발생: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/icon/appbar_logo.png',
          height: 40,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                // 로그 출력
                if (_selectedImage != null) {
                  debugPrint('선택한 사진이 있습니다. 경로: ${_selectedImage!.path}');
                  PostDialog.show(
                    context,
                    ref,
                    selectedImage: _selectedImage!,
                    rootContext: context,
                  );
                } else {
                  debugPrint('선택한 사진이 없습니다.');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('사진을 먼저 선택해주세요.')),
                  );
                }
              },
              child: SizedBox(
                width: 50,
                height: 50,
                child: Image.asset('assets/icon/pen.png'),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 사진 추가 박스
            Container(
              width: 300,
              height: 280,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(12),
              ),
              child: GestureDetector(
                onTap: () async {
                  final image = await Picker.show(context);
                  if (image != null) {
                    setState(() {
                      _selectedImage = image;
                    });
                    debugPrint('사진 선택 완료: ${_selectedImage!.path}');
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: _selectedImage != null
                      ? Image.file(
                          _selectedImage!,
                          fit: BoxFit.cover,
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icon/image_pick.png',
                                width: 40,
                                height: 40,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "사진을 추가해주세요",
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 작은 사진 박스 5개 (가로 스크롤)
            SizedBox(
              height: 110,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(5, (index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: (_allGalleryPhotos.length > index)
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                _allGalleryPhotos[index],
                                fit: BoxFit.cover,
                              ),
                            )
                          : null,
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
