import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Header Text ===
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Text(
                  "Welcome to\nMyMusic 🎧",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent.shade200,
                    height: 1.4,
                    letterSpacing: 0.8,
                    shadows: [
                      Shadow(
                        color: Colors.pinkAccent.withOpacity(0.2),
                        offset: const Offset(1, 1),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),

              // === FULL HEADER IMAGE ===
              Container(
                margin: const EdgeInsets.only(bottom: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pinkAccent.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  'assets/images/pp.jpg',
                  width: double.infinity,
                  height: 240,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),

              // === New Albums Section ===
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "New Albums",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/list');
                    },
                    child: const Text(
                      "See all",
                      style: TextStyle(color: Colors.pinkAccent),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              SizedBox(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _albumCard('assets/images/foto1.jpg', 'Mangu', 'Fourtwnty'),
                    _albumCard('assets/images/foto2.jpg', 'Alamak', 'Rizky Febian'),
                    _albumCard('assets/images/foto3.jpg', 'Kita Usahakan Lagi', 'Batas Senja'),
                    _albumCard('assets/images/foto4.jpg', 'Tanpa Cinta', 'Tiara Andini'),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // === Song List Section ===
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Song List",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/list');
                    },
                    child: const Text(
                      "See all",
                      style: TextStyle(color: Colors.pinkAccent),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // === List Lagu Singkat ===
              _songTile('assets/images/gambar6.jpg', 'Lovely', 'Billie Eilish'),
              _songTile('assets/images/gambar7.jpg', 'Gone', 'Rose'),
              _songTile('assets/images/gambar8.jpg', 'Love Story', 'Taylor Swift'),
            ],
          ),
        ),
      ),
    );
  }

  // === Album Card ===
  Widget _albumCard(String img, String title, String artist) {
    return Container(
      margin: const EdgeInsets.only(right: 14),
      width: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.pink.shade50,
        boxShadow: [
          BoxShadow(
            color: Colors.pinkAccent.withOpacity(0.15),
            blurRadius: 5,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(
              img,
              height: 90,
              width: 130,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  artist,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // === Song Tile ===
  Widget _songTile(String img, String title, String artist) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          img,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      subtitle: Text(
        artist,
        style: const TextStyle(color: Colors.grey, fontSize: 13),
      ),
      trailing: Icon(Icons.more_vert, color: Colors.pink.shade300),
    );
  }
}
