import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/theme.dart';
import 'package:music_app/utils/color.ex.dart';
import 'package:music_app/utils/timer.ex.dart';
import 'package:music_app/widgets/ScreenContainer.dart';
import 'package:music_app/widgets/VideoBackground.dart';

import '../providers/audio-player.provider.dart';

class TrackPage extends ConsumerWidget {
  const TrackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPlaying = ref.watch(audioPlayerProvider).isPlaying;
    final track = ref.watch(audioPlayerProvider).track;
    final pause = ref.watch(audioPlayerProvider.notifier).pause;
    final resume = ref.watch(audioPlayerProvider.notifier).resume;
    final duration = ref.watch(audioPlayerProvider).duration;
    final position = ref.watch(audioPlayerProvider).position;
    final isSuffer = ref.watch(audioPlayerProvider).isShuffle;
    final isRepeat = ref.watch(audioPlayerProvider).isRepeat;
    final nextTrack = ref.watch(audioPlayerProvider.notifier).nextTrack;
    final previousTrack = ref.watch(audioPlayerProvider.notifier).previousTrack;
    final toggleRepeat = ref.watch(audioPlayerProvider.notifier).toggleRepeat;
    final toggleShuffle = ref.watch(audioPlayerProvider.notifier).toggleShuffle;
    final seek = ref.watch(audioPlayerProvider.notifier).seek;

    void pauseTrack() {
      pause();
    }

    void resumeTrack() {
      resume();
    }

    return ScreenContainer(
        withTopBar: true,
        withBackButton: true,
        title: "",
        body: VideoBackground(
          videoUrl: track?.videoUrl ?? "",
          children: [
            Column(
              children: [
                //Track cover image
                Column(
                  children: [
                    FutureBuilder<Color>(
                      future: exportDominantColor(track!.coverUrl),
                      initialData: Colors.white,
                      builder: (context, snapshot) => Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(track.coverUrl),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              //0 0 0 0
                              BoxShadow(
                                color: snapshot.data!.withOpacity(0.13),
                                spreadRadius: 0,
                                blurRadius: 0,
                                offset: const Offset(
                                  0,
                                  0,
                                ), // changes position of shadow
                              ),
                              BoxShadow(
                                color: snapshot.data!.withOpacity(0.05),
                                spreadRadius: 0,
                                blurRadius: 5,
                                offset: const Offset(
                                  2,
                                  5,
                                ), // changes position of shadow
                              ),
                              BoxShadow(
                                color: snapshot.data!.withOpacity(0.09),
                                blurRadius: 9,
                                spreadRadius: 0,
                                offset: const Offset(
                                  0,
                                  9,
                                ), // changes position of shadow
                              ),
                              BoxShadow(
                                color: snapshot.data!.withOpacity(0.1),
                                blurRadius: 12,
                                spreadRadius: 0,
                                offset: const Offset(
                                  0,
                                  12,
                                ), // changes position of shadow
                              ),
                            ]),
                      ),
                    ),
                    const SizedBox(height: 20),
                    //Track title
                    Text(
                      track.title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    //Track artist
                    Text(
                      track.artist,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                //Track progress bar
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //Track progress bar
                      Slider(
                        value: position.inSeconds.toDouble(),
                        min: 0,
                        max: duration.inSeconds.toDouble(),
                        onChanged: (value) {
                          seek(Duration(seconds: value.toInt()));
                        },
                      ),
                      //Track progress time
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            position.formatted,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            duration.formatted,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
                //Track controls
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 40,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        isSelected: isSuffer,
                        disabledColor: Gray.gray500,
                        onPressed: toggleShuffle,
                        iconSize: 30,
                        icon: Icon(
                          Icons.shuffle,
                          color: !isSuffer
                              ? Gray.gray500
                              : Theme.of(context).colorScheme.onBackground,
                        ),
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                      IconButton(
                        onPressed: previousTrack,
                        iconSize: 30,
                        icon: Icon(
                          Icons.skip_previous,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                      IconButton(
                        iconSize: 80,
                        onPressed: isPlaying ? pauseTrack : resumeTrack,
                        icon: Icon(
                          isPlaying
                              ? Icons.pause_circle
                              : Icons.play_arrow_rounded,
                          color: Theme.of(context).colorScheme.primary,
                          shadows: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.4),
                              blurRadius: 12,
                              spreadRadius: 5,
                              offset: const Offset(
                                0,
                                3,
                              ), // changes position of shadow
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        //Disable any feedback from the button
                        enableFeedback: false,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        //scale on press
                      ),
                      IconButton(
                        onPressed: nextTrack,
                        iconSize: 30,
                        icon: Icon(
                          Icons.skip_next,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                      IconButton(
                        onPressed: toggleRepeat,
                        iconSize: 30,
                        icon: Icon(
                          Icons.repeat,
                          color: isRepeat
                              ? Theme.of(context).colorScheme.onBackground
                              : Gray.gray500,
                        ),
                        enableFeedback: false,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
