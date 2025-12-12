import 'package:flutter/material.dart';
import 'package:uas_mobile/models/item_model.dart';

class CustomCard extends StatelessWidget {
  final ItemModel item;

  const CustomCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1E1E1E), // warna abu hitam elegan
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            item.gambar,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          item.judul,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          item.penyanyi,
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: Image.asset(
          'assets/icons/info.png', // ikon info di kanan
          width: 30,
          height: 30,
          color: Colors.white70,
        ),
      ),
    );
  }
}
