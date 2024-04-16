import 'package:flutter/material.dart';

class StarterPageView extends StatefulWidget {
  const StarterPageView({super.key});


  @override
  State<StarterPageView> createState() => _StarterPageViewState();
}

class _StarterPageViewState extends State<StarterPageView> {
  final List<int> items= List.generate(5, (index) => index);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: PageView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:Colors.black,
              ),
              child: Wrap(
                children: List.generate(index+1, (index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.yellow,
                    ),
                    height: 50,
                    child: ListTile(
                      title: Text('Page ${index+1}'),
                    ),
                  );

                }),
              )
          );
        },
      ),
    );
  }
}


