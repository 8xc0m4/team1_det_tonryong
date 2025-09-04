import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:team1_det_tonryong/presentation/page/detail/detail_page.dart';
import 'package:team1_det_tonryong/presentation/page/home/home_view_model.dart';

class HomeList extends ConsumerStatefulWidget {
  const HomeList({
    required this.result,
    required this.userNickNM,
    required this.userProfil,
    required this.uid,
  });
  final HomeState result;
  final String userNickNM;
  final String userProfil;
  final String uid;

  @override
  ConsumerState<HomeList> createState() => _HomeListState();
}

class _HomeListState extends ConsumerState<HomeList> {
  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (notification.metrics.maxScrollExtent > 0 &&
              notification.metrics.pixels >=
                  notification.metrics.maxScrollExtent - 50) {
            setState(() {
              ref.watch(homeViewModelProvider);
              ref.read(homeViewModelProvider.notifier).loadMorePhoto();
            });
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
        itemCount: widget.result.getFeedsPhoto!.length,
        itemBuilder: (context, index) {
          final feed = widget.result.getFeedsPhoto![index];
          return GestureDetector(
            onTap: () async {
              bool? deleted = await Navigator.push(
                //
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return DetailPage(
                      feedPhoto: feed.feedPhoto,
                      feedId: feed.feedId,
                      feedTime: feed.feedTime,
                      writerNM: feed.userNM,
                      fLikeUsers: feed.fLikeUsers,
                      userNickNM: widget.userNickNM,
                      userProfil: widget.userProfil,
                      tag: widget.result.getFeedsPhoto![index].feedPhoto,
                      feedLike: feed.feedLike,
                      userId: feed.feedId,
                    );
                  },
                ),
              );
              if (deleted == true) {
                //
                ref
                    .read(homeViewModelProvider.notifier)
                    .deleteFeed(feed.feedId);
              }
            },
            child: Hero(
              tag: widget.result.getFeedsPhoto![index].feedPhoto,
              child: Container(
                color: Colors.grey,
                child: Image.network(
                  widget.result.getFeedsPhoto![index].feedPhoto,
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
