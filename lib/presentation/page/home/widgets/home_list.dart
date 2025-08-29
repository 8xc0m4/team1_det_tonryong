import 'package:flutter/material.dart';

class HomeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 10,
        childAspectRatio: 1.3
      ),
      itemCount: 20,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            //
          },
          child: Hero(
            tag: '',
            child: Container(
              color: Colors.grey,
              child: Image.network(
                'https://picsum.photos/200/300',
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
