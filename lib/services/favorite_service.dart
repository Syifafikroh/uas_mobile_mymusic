import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uas_mobile/models/item_model.dart';

class FavoriteService {
  static const String key = "favorite_songs";

  Future<List<ItemModel>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(key) ?? [];
    return data.map((e) => ItemModel.fromJson(jsonDecode(e))).toList();
  }

  Future<void> addFavorite(ItemModel item) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(key) ?? [];

    data.add(jsonEncode(item.toJson()));
    prefs.setStringList(key, data);
  }

  Future<void> removeFavorite(int trackId) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(key) ?? [];

    data.removeWhere((song) {
      final json = jsonDecode(song);
      return json["trackId"] == trackId;
    });

    prefs.setStringList(key, data);
  }

  Future<bool> isFavorite(int trackId) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(key) ?? [];

    return data.any((song) {
      final json = jsonDecode(song);
      return json["trackId"] == trackId;
    });
  }
}
