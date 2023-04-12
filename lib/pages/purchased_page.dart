import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/models/playlist.model.dart';
import 'package:music_app/pages/user_page.dart';
import 'package:music_app/providers/audio-player.provider.dart';
import 'package:music_app/providers/auth.provider.dart';
import 'package:music_app/providers/packages.provider.dart';

import '../models/package.model.dart';
import '../providers/pick-playlist.provider.dart';
import '../theme.dart';
import '../widgets/BottomPlayBar.dart';

class PurchasedPage extends ConsumerWidget {
  const PurchasedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isLoading = ref.watch(packagesProvider).isLoading;
    final bool isAuth = ref.watch(authControllerProvider).isAuth;
    void _openPackage(Package package) {
      ref.read(pickPlaylistProvider.notifier).setPackage(package);
      Navigator.pushNamed(context, "/package");
    }

    void _openPlaylist(Playlist playlist, Package package) {
      ref.read(pickPlaylistProvider.notifier).setPlaylist(playlist);
      Navigator.pushNamed(context, "/playlist");
    }

    final track = ref.watch(audioPlayerProvider).track;
    final List<Package> unlockPackages =
        ref.watch(packagesProvider).unlockedPackages;

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        //Player
        // bottomNavigationBar: track != null ? const BottomPlaybar() : null,
        bottomSheet: track != null ? const BottomPlaybar() : null,
        body: isAuth
            ? SafeArea(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: unlockPackages.length,
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
                                          if (!unlockPackages
                                              .contains(unlockPackages[pIndex]))
                                            const Icon(
                                              Icons.lock_rounded,
                                              size: 18,
                                              color: Gray.gray500,
                                            ),
                                          Text(
                                            unlockPackages[pIndex].name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                        ],
                                      ),
                                      //See more link
                                      TextButton(
                                        onPressed: () {
                                          _openPackage(unlockPackages[pIndex]);
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
                                        itemCount: unlockPackages[pIndex]
                                            .playlistModels!
                                            .length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return GestureDetector(
                                            onTap: () => _openPlaylist(
                                                unlockPackages[pIndex]
                                                    .playlistModels![index],
                                                unlockPackages[pIndex]),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
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
                                                            unlockPackages[
                                                                    pIndex]
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
                                                      children: [
                                                        Text(
                                                          unlockPackages[pIndex]
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
                                                            getArtists(unlockPackages[
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
              )
            : const RequiredLogin());
  }
}
