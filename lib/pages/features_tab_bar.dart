import 'package:flutter/material.dart';
import 'package:spotiflyer_open_source/pages/downloader_page.dart';
import 'package:spotiflyer_open_source/pages/music_player.dart';
import 'package:spotiflyer_open_source/pages/recommendation.dart';

class Features extends StatelessWidget {
  const Features({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TabBar(
          labelColor: Colors.black,
          tabs: [
            Tab(
              text: "Discover",
              icon: Icon(Icons.explore),
            ),
            Tab(
              text: "Library",
              icon: Icon(Icons.my_library_music),
            ),
            Tab(
              text: "Download",
              icon: Icon(Icons.download),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            Center(child: RecommendationPage()),
            Center(child: MusicPlayerTab()),
            Center(child: DownloaderPage()),
          ],
        ),
      ),
    );
  }
}
