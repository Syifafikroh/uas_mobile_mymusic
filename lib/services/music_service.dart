import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uas_mobile/models/item_model.dart';

class MusicService {
  Future<List<ItemModel>> fetchSongs(String query) async {
    print("Fetching: https://itunes.apple.com/search?term=$query&entity=song");

    final url = Uri.parse(
      "https://itunes.apple.com/search?term=$query&entity=song",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data["results"];
      return results.map((e) => ItemModel.fromJson(e)).toList();
    } else {
      throw Exception("Gagal mengambil data dari API");
    }
  }

  // opsional: untuk HomePage (album)
  Future<List<ItemModel>> fetchPopularSongs() async {
    final url = Uri.parse(
      "https://itunes.apple.com/search?term=top&entity=song&limit=10",
    );

    print("Fetching Popular Songs: $url");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data["results"];
      return results.map((e) => ItemModel.fromJson(e)).toList();
    } else {
      throw Exception("Gagal mengambil data popular");
    }
  }
}
