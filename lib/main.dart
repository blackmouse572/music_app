import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/firebase_options.dart';
import 'package:music_app/pages/home_page.dart';
import 'package:music_app/pages/purchased_page.dart';
import 'package:music_app/pages/user_page.dart';
import 'package:music_app/routes.dart';
import 'package:music_app/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      onGenerateRoute: Routes.generateRoute,
      theme: chakraTheme,
      title: "Music box",
      home: const AppScaffold(),
    );
  }
}

class AppScaffold extends ConsumerStatefulWidget {
  const AppScaffold({Key? key}) : super(key: key);

  @override
  _AppScaffoldState createState() => _AppScaffoldState();
}

class _AppScaffoldState extends ConsumerState<AppScaffold> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  final List<Widget> _pages = const <Widget>[
    HomePage(),
    PurchasedPage(),
    UserPage(),
  ];
  final List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: "Purchased",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: "User",
    ),
  ];
  void changePage(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
          child: PageView.builder(
        controller: _pageController,
        itemCount: _pages.length,
        itemBuilder: (BuildContext context, int index) {
          return _pages[index];
        },
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      )),
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        backgroundColor: Gray.gray900.withOpacity(0.9),
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).textTheme.bodySmall!.color,
        onTap: changePage,
      ),
    );
  }
}
