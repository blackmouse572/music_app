import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/models/playlist.model.dart';
import 'package:music_app/providers/pick-playlist.provider.dart';
import 'package:music_app/theme.dart';
import 'package:music_app/widgets/ScreenContainer.dart';

class Package extends ConsumerWidget {
  const Package({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Get the playlist from the provider
    final package = ref.watch(pickPlaylistProvider).package!;
    void _onTap(Playlist playlist) {
      ref.read(pickPlaylistProvider.notifier).setPlaylist(playlist);
      Navigator.pushNamed(context, "/playlist");
    }

    return ScreenContainer(
        withTopBar: true,
        withBackButton: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Playlist',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: package.playlists.length,
                    itemBuilder: (context, index) {
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _onTap(package.playlistModels![index]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: Row(
                              children: [
                                //Image of the playlist
                                Image.network(
                                  package.playlistModels![index].thumbnailUrl,
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 10),
                                //Name of the playlist
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        package.playlistModels![index].name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      Text(
                                        getArtists(
                                            package
                                                .playlistModels![index].tracks,
                                            maxCharacters: 20),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      )
                                    ],
                                  ),
                                ),
                                Text(
                                  '(${package.playlistModels![index].tracks.length} Bài)',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: Gray.gray500,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })
              ],
            ),
          ),
        ));
  }
}
