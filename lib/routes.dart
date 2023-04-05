//Route system
import 'package:flutter/material.dart';
import 'package:music_app/pages/home_page.dart';
import 'package:music_app/pages/package.dart';
import 'package:music_app/pages/playlist.dart';
import 'package:music_app/pages/purchased_page.dart';
import 'package:music_app/pages/track.dart';

//Implement: https://flutter.dev/docs/cookbook/navigation/named-routes
class Routes {
  static const String home = '/';
  static const String playlist = '/playlist';
  static const String track = '/track';
  static const String package = '/package';
  static const String purchased = '/purchased';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case playlist:
        return MaterialPageRoute(builder: (_) => const PlaylistPage());
      case track:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const TrackPage(),
          transitionDuration: const Duration(milliseconds: 200),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          fullscreenDialog: true,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              //Move from bottom to top with opacity
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      case package:
        return MaterialPageRoute(builder: (_) => const Package());
      case purchased:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const PurchasedPage(),
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
