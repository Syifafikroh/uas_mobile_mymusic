import 'package:flutter/material.dart';
import 'package:uas_mobile/models/item_model.dart';
import 'package:uas_mobile/services/favorite_service.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final FavoriteService _favService = FavoriteService();
  List<ItemModel> favorites = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    favorites = await _favService.getFavorites();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Favorite Songs",
            style: TextStyle(
                color: Colors.pinkAccent, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.pinkAccent),
      ),

      body: favorites.isEmpty
          ? const Center(
        child: Text("No favorites yet ❤️",
            style: TextStyle(fontSize: 18, color: Colors.grey)),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final item = favorites[index];

          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/detail", arguments: item);
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.pink.shade50,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(item.gambar,
                        width: 60, height: 60, fit: BoxFit.cover),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item.judul,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.pink),
                    onPressed: () async {
                      await _favService.removeFavorite(item.trackId);
                      loadFavorites();
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
