import 'package:flutter/material.dart';

class ScreenContainer extends StatelessWidget {
  const ScreenContainer(
      {Key? key,
      required this.body,
      this.title = "Music box",
      this.withBackButton = false,
      this.withTopBar = false})
      : super(key: key);
  final Widget body;
  final withTopBar;
  final withBackButton;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: withTopBar
            ? AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: withBackButton
                    ? IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back),
                      )
                    : null,
                title: Text(title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          fontWeight: FontWeight.w600,
                        )),
              )
            : null,
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(child: body));
  }
}
