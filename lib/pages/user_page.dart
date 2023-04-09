import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/providers/auth.provider.dart';
import 'package:music_app/providers/point_provider.dart';
import 'package:music_app/widgets/ScreenContainer.dart';

class UserPage extends ConsumerWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //If the user is not logged in, show the login screen
    final signOut = ref.watch(authControllerProvider.notifier).signOut;
    final isAuth = ref.watch(authControllerProvider).isAuth;
    final user = ref.watch(authControllerProvider).user;
    final points = ref.watch(pointProvider).point;
    final updatePoint = ref.watch(pointProvider.notifier).addPoint;

    void _addPoint() {
      updatePoint(context);
    }

    return ScreenContainer(
        body: !isAuth
            ? const RequiredLogin()
            : Column(
                children: [
                  //Point to the user's profile
                  Container(
                    height: 200,
                    padding: const EdgeInsets.all(40),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Text('Điểm',
                            style: Theme.of(context).textTheme.bodyMedium),
                        Text(
                          points.toString(),
                          // "0",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  //User info
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: Column(children: [
                      Text('Email: ${user?.email}'),
                      Text('UID: ${user?.uid}'),
                      ButtonBar(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _addPoint();
                            },
                            child: const Text('+1 điểm'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              signOut();
                            },
                            child: const Text('Đăng xuất'),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ],
              ));
  }
}

class RequiredLogin extends StatelessWidget {
  const RequiredLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Bạn cần đăng nhập để sử dụng tính năng này'),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: const Text('Đăng nhập'),
          ),
        ],
      ),
    );
  }
}
