import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/models/playlist.model.dart';
import 'package:music_app/models/track.model.dart';
import 'package:music_app/providers/audio-player.provider.dart';
import 'package:music_app/widgets/ScreenContainer.dart';

import '../providers/pick-playlist.provider.dart';

class PlaylistPage extends ConsumerWidget {
  const PlaylistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlist = ref.watch(pickPlaylistProvider).playlist!;
    final setPlayingTrack =
        ref.watch(pickPlaylistProvider.notifier).setPlayingTrack;
    final setPlayingPlaylist =
        ref.watch(pickPlaylistProvider.notifier).setPlaylist;
    final init = ref.watch(audioPlayerProvider.notifier).init;
    final play = ref.watch(audioPlayerProvider.notifier).play;
    final playRandom = ref.watch(audioPlayerProvider.notifier).playRandomTrack;
    final isPlaying = ref.watch(audioPlayerProvider).isPlaying;
    final playingList = ref.watch(pickPlaylistProvider).playlist;
    final playingTrack = ref.watch(pickPlaylistProvider).playingTrack;
    final setPlaylist = ref.watch(audioPlayerProvider.notifier).setPlaylist;

    void playPlaylist(List<Track> playlists, Playlist playlist,
        {int index = 0}) {
      init(playlists);
      setPlaylist(playlists);
      setPlaylist(playlists);

      setPlayingTrack(playlists[index]);
      setPlayingPlaylist(playlist);
      play(playlists[index]);
    }

    void suffer() {
      playPlaylist(playlist.tracks, playlist, index: 0);
      playRandom();
    }

    void selectTrack(Track track) {
      setPlayingTrack(track);
      play(track);
    }

    return ScreenContainer(
      withTopBar: true,
      withBackButton: true,
      title: "",
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(playlist.thumbnailUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                playlist.name,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontWeight: FontWeight.w500,
                    ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 5),
              Text(
                getArtists(playlist.tracks, maxCharacters: 30),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  //PLay button
                  ElevatedButton(
                    onPressed: () {
                      //If current playlist is playing, pause
                      if (isPlaying && playingList == playlist) {
                        ref.watch(audioPlayerProvider.notifier).pause();
                      } else {
                        playPlaylist(playlist.tracks, playlist, index: 0);
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).colorScheme.primary),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ),
                    child: Row(
                      children:
                          //If current playlist is playing, show pause icon
                          (isPlaying && playingList == playlist)
                              ? <Widget>[
                                  const Icon(Icons.pause),
                                  const SizedBox(width: 5),
                                  Text('Tạm dừng',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                          ))
                                ]
                              : <Widget>[
                                  const Icon(Icons.play_arrow),
                                  const SizedBox(width: 5),
                                  Text('Phát',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                          ))
                                ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  //Shuffle ghost button
                  ElevatedButton(
                    onPressed: () {
                      ref.watch(audioPlayerProvider.notifier).stop();
                      suffer();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).colorScheme.background),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ),
                    child: Row(
                      children: const <Widget>[
                        Icon(Icons.shuffle),
                        SizedBox(width: 5),
                        Text('Ngẫu nhiên'),
                      ],
                    ),
                  ),
                ],
              ),

              //Top tracks
              const SizedBox(height: 10),
              Text(
                'Top',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                    ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 10),
              ListView.builder(
                itemCount: playlist.tracks.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          selectTrack(playlist.tracks[index]);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      playlist.tracks[index].coverUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  playlist.tracks[index].title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: playingTrack ==
                                                playlist.tracks[index]
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                      ),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  getArtistsFromTrack(playlist.tracks[index],
                                      maxCharacters: 30),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
