import 'package:flutter/material.dart';

class DownloaderPage extends StatelessWidget {
  const DownloaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DownloadSongField(),
    );
  }
}

class DownloadSongField extends StatelessWidget {
  const DownloadSongField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(50),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Paste Link',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: ElevatedButton(
            child: const Text("Download Now"),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
