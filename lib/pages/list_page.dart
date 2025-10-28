import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uts_mobile/models/item_model.dart';
import 'package:uts_mobile/widgets/custom_card.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late Future<List<ItemModel>> _laguList;
  String searchQuery = '';

  Future<List<ItemModel>> readJsonData() async {
    final jsonData = await rootBundle.loadString('lib/data/lagu.json');
    final list = json.decode(jsonData) as List<dynamic>;
    return list.map((e) => ItemModel.fromJson(e)).toList();
  }

  @override
  void initState() {
    super.initState();
    _laguList = readJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.pinkAccent),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Daftar Lagu',
          style: TextStyle(
            color: Colors.pinkAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<ItemModel>>(
        future: _laguList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.pinkAccent),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Tidak ada data lagu.',
                  style: TextStyle(color: Colors.grey)),
            );
          } else {
            final lagu = snapshot.data!
                .where((e) =>
            e.judul.toLowerCase().contains(searchQuery.toLowerCase()) ||
                e.penyanyi
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase()))
                .toList();

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // === Search Bar ===
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade50,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.search, color: Colors.pinkAccent),
                        hintText: "Cari lagu atau penyanyi...",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() => searchQuery = value);
                      },
                    ),
                  ),
                  const SizedBox(height: 10),

                  // === List Lagu ===
                  Expanded(
                    child: ListView.builder(
                      itemCount: lagu.length,
                      itemBuilder: (context, index) {
                        final item = lagu[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/detail',
                                arguments: item);
                          },
                          child: Card(
                            color: Colors.pink.shade50,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 4),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  item.gambar,
                                  width: 55,
                                  height: 55,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                item.judul,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                item.penyanyi,
                                style: const TextStyle(color: Colors.grey),
                              ),
                              trailing: Image.asset(
                                'assets/icons/info.png',
                                width: 25,
                                height: 25,
                                color: Colors.pinkAccent,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
