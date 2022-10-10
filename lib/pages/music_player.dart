import 'dart:ffi';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

// import 'package:path_provider_ex/path_provider_ex.dart';
int songDuration = 0;
var currentDuration = 0;

class MusicPlayerTab extends StatelessWidget {
  const MusicPlayerTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AudioFileLister(),
      extendBody: true,
    );
  }
  // Widget build(BuildContext context) {
  //   return Column(

  //     children: [AudioFileLister()],
  //   );
  // }
}

class AudioFileLister extends StatefulWidget {
  const AudioFileLister({super.key});

  @override
  State<AudioFileLister> createState() => _AudioFileListerState();
}

class _AudioFileListerState extends State<AudioFileLister> {
  final OnAudioQuery _onAudioQuery = OnAudioQuery();
  final AudioPlayer _player = AudioPlayer();
  bool songPlaying = false;

  @override
  void initState() {
    super.initState();
    requestStoragePermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<SongModel>>(
        future: _onAudioQuery.querySongs(
            sortType: null,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            ignoreCase: true),
        builder: (context, item) {
          if (item.data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (item.data!.isEmpty) {
            return const Center(
              child: Text("No Songs Found"),
            );
          }
          return ListView.builder(
              itemCount: item.data!.length,
              itemBuilder: ((context, index) {
                return ListTile(
                  minVerticalPadding: 15,
                  hoverColor: Colors.grey,
                  title: (Text(item.data![index].title)),
                  // subtitle: (Text(item.data![index].displayName)),
                  trailing: Column(
                    children: [
                      TextButton(
                        onPressed: () async {
                          if (songPlaying) {
                            await _player.pause();
                          }
                          if (!songPlaying) {
                            await _player
                                .play(DeviceFileSource(item.data![index].data));
                            songDuration = (await _player.getDuration()) as int;
                          }
                          setState(() {
                            songPlaying = !songPlaying;
                          });
                        },
                        child: songPlaying
                            ? const Icon(Icons.pause)
                            : const Icon(Icons.play_arrow),
                      ),
                      Text(
                        parseToMinutesSeconds(
                            (item.data![index].duration) as int),
                        style: const TextStyle(fontSize: 7),
                      )
                    ],
                  ),
                  leading: QueryArtworkWidget(
                    id: item.data![index].id,
                    type: ArtworkType.AUDIO,
                  ),
                  onTap: () async {
                    final snackBar = SnackBar(
                      content:
                          Text("Now Playing...\n ${item.data![index].title}"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                );
              }));
        },
      ),
    );
  }

  void requestStoragePermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await _onAudioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _onAudioQuery.permissionsRequest();
      }
    }
    setState(() {});
  }

  static String parseToMinutesSeconds(int ms) {
    String data;
    Duration duration = Duration(milliseconds: ms);

    int minutes = duration.inMinutes;
    int seconds = (duration.inSeconds) - (minutes * 60);

    data = "$minutes:";
    if (seconds <= 9) data += "0";

    data += seconds.toString();
    return data;
  }
}
