import 'package:flutter/material.dart';

class BottomNavigationBar extends StatelessWidget {
  const BottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.home),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.favorite),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.person),
        ),
      ]),
    ));
  }
}
