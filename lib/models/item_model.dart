class ItemModel {
  final String judul;
  final String penyanyi;
  final String genre;
  final String gambar;

  ItemModel({
    required this.judul,
    required this.penyanyi,
    required this.genre,
    required this.gambar,
  });

  // Constructor untuk parsing dari JSON
  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      judul: json['judul'] ?? '',
      penyanyi: json['penyanyi'] ?? '',
      genre: json['genre'] ?? '',
      gambar: json['gambar'] ?? '',
    );
  }

  // (opsional) Convert kembali ke Map, misal kalau kamu mau save ke JSON lagi
  Map<String, dynamic> toJson() {
    return {
      'judul': judul,
      'penyanyi': penyanyi,
      'genre': genre,
      'gambar': gambar,
    };
  }
}
