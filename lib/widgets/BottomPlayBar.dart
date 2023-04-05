import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/providers/audio-player.provider.dart';

class BottomPlaybar extends ConsumerWidget {
  const BottomPlaybar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPlaying = ref.watch(audioPlayerProvider).isPlaying;
    final track = ref.watch(audioPlayerProvider).track;
    final pause = ref.watch(audioPlayerProvider.notifier).pause;
    final resume = ref.watch(audioPlayerProvider.notifier).resume;
    final duration = ref.watch(audioPlayerProvider).duration;
    final position = ref.watch(audioPlayerProvider).position;
    void pauseTrack() {
      pause();
    }

    void resumeTrack() {
      resume();
    }

    return GestureDetector(
      onTap: () {
        //Bottom to Top animation
        Navigator.of(context).pushNamed('/track');
      },
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: ClipRRect(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
              //blur backdrop effect
              boxShadow: [
                BoxShadow(
                  color:
                      Theme.of(context).colorScheme.background.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ], //blur backdrop effect
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(clipBehavior: Clip.antiAlias, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(track!.coverUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              track.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                            Text(
                              track.artist,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        isPlaying ? pauseTrack() : resumeTrack();
                      },
                      icon: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      enableFeedback: false,
                      highlightColor: Colors.transparent,
                      //remove splash effect
                      splashColor: Colors.transparent,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: -2,
                right: 0,
                left: 0,
                child: LinearProgressIndicator(
                  value: position.inSeconds / duration.inSeconds,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                  backgroundColor: Colors.white.withOpacity(0.5),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
