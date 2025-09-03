import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team1_det_tonryong/presentation/page/detail/detail_page.dart';
import 'package:team1_det_tonryong/presentation/page/home/home_view_model.dart';
import 'package:team1_det_tonryong/presentation/page/write/write_page.dart';

class HomeList extends ConsumerWidget {
  HomeList(this.result);
  final HomeState result;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (notification.metrics.maxScrollExtent > 0 &&
              notification.metrics.pixels >=
                  notification.metrics.maxScrollExtent - 50) {
            ref.read(homeViewModelProvider.notifier).loadMorePhoto();
          }
        }
        return false;
      },
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 3,
          crossAxisSpacing: 3,
          childAspectRatio: 1.3,
        ),
        itemCount: result.getFeedsPhoto!.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return WritePage();
                  },
                ),
              );
            },
            child: Hero(
              tag: result.getFeedsPhoto![index].feedPhoto,
              child: Container(
                color: Colors.grey,
                child: Image.network(
                  result.getFeedsPhoto![index].feedPhoto,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
