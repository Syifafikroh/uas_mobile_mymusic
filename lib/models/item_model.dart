class ItemModel {
  final int trackId;
  final String judul;
  final String penyanyi;
  final String gambar;
  final String previewUrl;
  final String genre;

  ItemModel({
    required this.trackId,
    required this.judul,
    required this.penyanyi,
    required this.gambar,
    required this.previewUrl,
    required this.genre,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      trackId: json["trackId"] ?? 0,
      judul: json["trackName"] ?? "-",
      penyanyi: json["artistName"] ?? "-",
      gambar: json["artworkUrl100"] ?? "",
      previewUrl: json["previewUrl"] ?? "",
      genre: json["primaryGenreName"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "trackId": trackId,
      "trackName": judul,
      "artistName": penyanyi,
      "artworkUrl100": gambar,
      "previewUrl": previewUrl,
      "primaryGenreName": genre,
    };
  }
}
