import 'package:flutter/material.dart';
import 'package:team1_det_tonryong/presentation/page/detail/detail_page.dart';
import 'package:team1_det_tonryong/presentation/page/home/home_view_model.dart';

class HomeList extends StatelessWidget {
  HomeList(this.result);
  final HomeState result;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 10,
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
                  return DetailPage();
                },
              ),
            );
          },
          child: Hero(
            tag: '$index',
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
    );
  }
}
