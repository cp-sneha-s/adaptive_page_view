import 'package:flutter/material.dart';
import 'package:infinite_page_view_demo/final/three_page_scroll_view.dart';

class FinalPageView extends StatefulWidget {
  const FinalPageView({super.key});

  @override
  State<FinalPageView> createState() => _FinalPageViewState();
}

class _FinalPageViewState extends State<FinalPageView> {
  final List<int> items = List.generate(3, (index) => index);

  int itemCount = 1;

  @override
  Widget build(BuildContext context) {
    return ThreePageScrollView(
        previous: itemCount==1?null:getItem(),
        current: getItem(),
        next: itemCount==5?null:getItem(),
        onPageChanged: (int direction) {
          setState(() {
            if(itemCount == 1 && direction == -1) {
              return;
            }
            itemCount += direction;
          });
        });
  }

  Widget getItem() {
    return Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        child: Wrap(
          children: List.generate(itemCount , (index) {
            return Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.yellow,
              ),
              height: 50,
              child: ListTile(
                title: Text('Page ${index + 1}'),
              ),
            );
          }),
        ));
  }
}
