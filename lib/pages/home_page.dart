import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/models/package.model.dart';
import 'package:music_app/models/playlist.model.dart';
import 'package:music_app/providers/audio-player.provider.dart';
import 'package:music_app/providers/auth.provider.dart';
import 'package:music_app/providers/packages.provider.dart';
import 'package:music_app/providers/pick-playlist.provider.dart';
import 'package:music_app/providers/point_provider.dart';
import 'package:music_app/routes.dart';
import 'package:music_app/theme.dart';
import 'package:music_app/widgets/BottomPlayBar.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unlockPackages = ref.watch(packagesProvider).unlockedPackages;
    final isAuth = ref.watch(authControllerProvider).isAuth;
    final unlock = ref.watch(packagesProvider.notifier).unlockPackage;
    final points = ref.watch(pointProvider).point;
    final updatePoint = ref.watch(pointProvider.notifier).updatePoint;
    void _onTap(Package package) {
      if (package.price == 0) {
        ref.read(pickPlaylistProvider.notifier).setPackage(package);
        Navigator.pushNamed(context, "/package");
      } else if (!isAuth) {
        _showUnlockDialog(context, () {
          Navigator.pushNamed(context, Routes.login);
        }, "Bạn cần đăng nhập để xem nội dung package và nghe playlist này",
            "Đăng nhập");
      } else if (!unlockPackages.contains(package)) {
        //If the package is not unlocked, show the alert
        _showUnlockDialog(context, () {
          if (isAuth && points >= package.price) {
            updatePoint(context, points - package.price);
            unlock(package, context);
          } else {
            //snackbar
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Bạn không đủ điểm để mua gói này"),
              duration: Duration(seconds: 2),
            ));
          }
        }, "Bạn cần mua gói để xem nội dung package và nghe playlist này",
            "Mua ngay (-${package.price})");
      } else {
        ref.read(pickPlaylistProvider.notifier).setPackage(package);
        Navigator.pushNamed(context, "/package");
      }
    }

    void _onTapPlaylist(Playlist playlist, Package package) {
      if (package.price == 0) {
        ref.read(pickPlaylistProvider.notifier).setPlaylist(playlist);
        Navigator.pushNamed(context, "/playlist");
      } else if (!isAuth) {
        _showUnlockDialog(context, () {
          Navigator.pushNamed(context, Routes.login);
        }, "Bạn cần đăng nhập để xem nội dung package và nghe playlist này",
            "Đăng nhập");
      } else if (!unlockPackages.contains(package)) {
        _showUnlockDialog(context, () {
          if (isAuth && points >= package.price) {
            updatePoint(context, points - package.price);
            unlock(package, context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Bạn không đủ điểm để mua gói này"),
              duration: Duration(seconds: 2),
            ));
          }
        }, "Bạn cần mua gói để xem nội dung package và nghe playlist này",
            "Mua ngay (-${package.price})");
      } else {
        ref.read(pickPlaylistProvider.notifier).setPlaylist(playlist);
        Navigator.pushNamed(context, "/playlist");
      }
    }

    final track = ref.watch(audioPlayerProvider).track;
    final List<Package> packages = ref.watch(packagesProvider).packages;
    final reFetch = ref.watch(packagesProvider.notifier).fetchPackages;
    final bool isLoading = ref.watch(packagesProvider).isLoading;
    final bool isErr = ref.watch(packagesProvider).isErrored;

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        //Player
        // bottomNavigationBar: track != null ? const BottomPlaybar() : null,
        bottomSheet: track != null ? const BottomPlaybar() : null,
        body: SafeArea(
          child: isLoading
              ? Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [CircularProgressIndicator()]),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: isErr
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('Error when fetching'),
                              ElevatedButton(
                                onPressed: () {
                                  reFetch();
                                },
                                child: const Text("Retry"),
                              ),
                            ],
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: packages.length,
                            itemBuilder: (BuildContext context, int pIndex) {
                              return Column(
                                children: [
                                  //Package name
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //If the package is not unlocked, show the lock icon
                                      Row(
                                        children: [
                                          if (packages[pIndex].price != 0 &&
                                              !unlockPackages
                                                  .contains(packages[pIndex]))
                                            const Icon(
                                              Icons.lock_rounded,
                                              size: 18,
                                              color: Gray.gray500,
                                            ),
                                          Text(
                                            packages[pIndex].name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                        ],
                                      ),
                                      //See more link
                                      TextButton(
                                        onPressed: () {
                                          _onTap(packages[pIndex]);
                                        },
                                        child: Text("Xem thêm",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  color: Primary.primary500,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                      ),
                                      //List of playlists
                                    ],
                                  ),
                                  SizedBox(
                                    height: 200,
                                    child: Row(children: [
                                      ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: packages[pIndex]
                                            .playlistModels!
                                            .length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return GestureDetector(
                                            onTap: () => _onTapPlaylist(
                                                packages[pIndex]
                                                    .playlistModels![index],
                                                packages[pIndex]),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  //Image of playlist
                                                  Container(
                                                    width: 100,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            packages[pIndex]
                                                                .playlistModels![
                                                                    index]
                                                                .thumbnailUrl),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  //Max width of text is 100
                                                  SizedBox(
                                                    width: 100,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          packages[pIndex]
                                                              .playlistModels![
                                                                  index]
                                                              .name,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall
                                                                  ?.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                            getArtists(packages[
                                                                        pIndex]
                                                                    .playlistModels?[
                                                                        index]
                                                                    .tracks ??
                                                                []),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    ]),
                                  )
                                ],
                              );
                            },
                          ),
                  ),
                ),
        ));
  }
}

Future<void> _showUnlockDialog(BuildContext context, VoidCallback onUnlock,
    String title, String content) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        icon: const Icon(
          Icons.lock_open_rounded,
          size: 40,
          color: Gray.gray500,
        ),
        title: Align(
          alignment: Alignment.center,
          child: Text(title, style: Theme.of(context).textTheme.bodyMedium),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onUnlock();
                },
                child: Text(content,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Primary.primary500,
                          fontWeight: FontWeight.w600,
                        )),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child:
                    Text("Huỷ", style: Theme.of(context).textTheme.bodyMedium),
              ),
            ],
          )
        ],
      );
    },
  );
}
