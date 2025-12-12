import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:uas_mobile/models/item_model.dart';
import 'package:uas_mobile/services/favorite_service.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final AudioPlayer _player = AudioPlayer();
  final FavoriteService _favService = FavoriteService();

  bool isFavorite = false;
  bool isPlaying = false;

  Duration currentPosition = Duration.zero;
  final Duration totalDuration = const Duration(seconds: 30);

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ItemModel item =
    ModalRoute.of(context)!.settings.arguments as ItemModel;

    // Listen audio progress
    _player.positionStream.listen((pos) {
      setState(() => currentPosition = pos);
    });

    // Cek favorite ketika halaman muncul
    Future.delayed(Duration.zero, () async {
      bool fav = await _favService.isFavorite(item.trackId);
      if (fav != isFavorite) {
        setState(() => isFavorite = fav);
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.pinkAccent),
        title: Text(
          item.judul,
          style: const TextStyle(
              color: Colors.pinkAccent, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.pinkAccent,
              size: 30,
            ),
            onPressed: () async {
              if (isFavorite) {
                await _favService.removeFavorite(item.trackId);
                setState(() => isFavorite = false);
              } else {
                await _favService.addFavorite(item);
                setState(() => isFavorite = true);
              }
            },
          )
        ],
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          children: [
            const SizedBox(height: 10),

            // COVER
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                item.gambar,
                width: 260,
                height: 260,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              item.judul,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              item.penyanyi,
              style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.pink.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                item.genre,
                style: const TextStyle(
                  color: Colors.pinkAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // PROGRESS TEXT
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_formatDuration(currentPosition),
                    style: const TextStyle(color: Colors.grey)),
                const Text("0:30", style: TextStyle(color: Colors.grey)),
              ],
            ),

            // SLIDER
            Slider(
              activeColor: Colors.pinkAccent,
              inactiveColor: Colors.pink.shade100,
              min: 0,
              max: totalDuration.inMilliseconds.toDouble(),
              value: currentPosition.inMilliseconds
                  .clamp(0, totalDuration.inMilliseconds)
                  .toDouble(),
              onChanged: (value) {
                _player.seek(Duration(milliseconds: value.toInt()));
              },
            ),

            const SizedBox(height: 15),

            // PLAY BUTTON
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () async {
                if (!isPlaying) {
                  await _player.setUrl(item.previewUrl);
                  await _player.play();
                } else {
                  await _player.pause();
                }
                setState(() => isPlaying = !isPlaying);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(isPlaying ? Icons.pause : Icons.play_arrow,
                      size: 28, color: Colors.white),
                  const SizedBox(width: 10),
                  Text(isPlaying ? "Pause" : "Play Preview",
                      style:
                      const TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${d.inMinutes}:${twoDigits(d.inSeconds % 60)}";
  }
}
