import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uas_mobile/models/item_model.dart';
import 'package:uas_mobile/services/music_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MusicService _api = MusicService();

  late Future<List<ItemModel>> newAlbums;
  late Future<List<ItemModel>> songList;

  String currentGenre = "pop";

  final List<String> genreList = [
    "pop", "rock", "indie", "jazz", "rnb", "kpop", "acoustic"
  ];

  // SLIDER CONTROLLER
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;
  Timer? _sliderTimer;

  @override
  void initState() {
    super.initState();

    newAlbums = _api.fetchPopularSongs();
    songList = _api.fetchSongs("love");

    // AUTOPLAY SLIDER
    _sliderTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (_pageController.hasClients) {
        _currentPage++;
        if (_currentPage >= 3) _currentPage = 0;

        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );

        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _sliderTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _changeGenre(String genre) {
    setState(() {
      currentGenre = genre;
      songList = _api.fetchSongs(genre);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ==========================
      // APPBAR DENGAN FAVORITE + LOGOUT
      // ==========================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "MyMusic 🎧",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.pinkAccent,
          ),
        ),
        actions: [
          // ❤️ FAVORITE PAGE
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.pinkAccent),
            onPressed: () {
              Navigator.pushNamed(context, "/favorite");
            },
          ),

          // 🚪 LOGOUT
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.pinkAccent),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool("isLoggedIn", false);

              // Kembali ke LoginPage dan hapus history
              Navigator.pushNamedAndRemoveUntil(
                  context, "/login", (route) => false);
            },
          ),
        ],
      ),

      // ==========================
      // BODY
      // ==========================
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ===== TITLE =====
              Text(
                "Welcome to\nMyMusic 🎧",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent.shade200,
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 20),

              // ===== SLIDER =====
              SizedBox(
                height: 200,
                child: PageView(
                  controller: _pageController,
                  children: [
                    _banner("assets/images/pp.jpg"),
                    _banner("assets/images/foto1.jpg"),
                    _banner("assets/images/foto2.jpg"),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ===== DOT INDICATOR =====
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 14 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? Colors.pinkAccent
                          : Colors.pink.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 30),

              // ===== SECTION NEW ALBUMS =====
              _sectionTitle("New Albums", () {
                Navigator.pushNamed(context, "/list");
              }),

              const SizedBox(height: 12),

              SizedBox(
                height: 180,
                child: FutureBuilder<List<ItemModel>>(
                  future: newAlbums,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return _albumShimmer();
                    }

                    if (snapshot.hasError) {
                      return const Center(child: Text("Failed to load albums"));
                    }

                    final items = snapshot.data!;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return _albumCard(items[index]);
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),

              // ===== GENRE CATEGORY =====
              const Text(
                "Genre",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: genreList.length,
                  itemBuilder: (context, index) {
                    final genre = genreList[index];
                    final bool selected = genre == currentGenre;

                    return GestureDetector(
                      onTap: () => _changeGenre(genre),
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? Colors.pinkAccent
                              : Colors.pink.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          genre.toUpperCase(),
                          style: TextStyle(
                            color: selected ? Colors.white : Colors.pink,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 25),

              // ===== SONG LIST SECTION =====
              _sectionTitle("Song List", () {
                Navigator.pushNamed(context, "/list");
              }),

              const SizedBox(height: 12),

              FutureBuilder<List<ItemModel>>(
                future: songList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _songShimmer();
                  }

                  if (snapshot.hasError) {
                    return const Center(child: Text("Failed to load songs"));
                  }

                  final items = snapshot.data!;
                  return Column(
                    children: items.map((e) => _songTile(e)).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===== COMPONENTS =====

  Widget _banner(String img) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(img, fit: BoxFit.cover),
    );
  }

  Widget _sectionTitle(String title, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style:
          const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: onTap,
          child: const Text(
            "See all",
            style: TextStyle(
              color: Colors.pinkAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _albumCard(ItemModel item) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/detail", arguments: item);
      },
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: Colors.pink.shade50,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(18)),
              child: Image.network(
                item.gambar,
                height: 110,
                width: 140,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.judul,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    item.penyanyi,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== SHIMMER =====
  Widget _albumShimmer() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      itemBuilder: (_, __) =>
          Shimmer.fromColors(
            baseColor: Colors.pink.shade100,
            highlightColor: Colors.white,
            child: Container(
              width: 140,
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                color: Colors.pink.shade50,
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
    );
  }

  Widget _songShimmer() {
    return Column(
      children: List.generate(
        5,
            (index) =>
            Shimmer.fromColors(
              baseColor: Colors.pink.shade100,
              highlightColor: Colors.white,
              child: Container(
                height: 70,
                margin: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
      ),
    );
  }

  Widget _songTile(ItemModel item) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/detail", arguments: item);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.pink.shade50,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child:
            Image.network(item.gambar, width: 55, height: 55),
          ),
          title: Text(
            item.judul,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            item.penyanyi,
            style: const TextStyle(color: Colors.grey),
          ),
          trailing: const Icon(Icons.chevron_right,
              color: Colors.pinkAccent),
        ),
      ),
    );
  }
}
