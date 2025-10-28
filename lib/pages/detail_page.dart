import 'package:flutter/material.dart';
import 'package:uts_mobile/models/item_model.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as ItemModel;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.pinkAccent),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          item.judul,
          style: const TextStyle(
            color: Colors.pinkAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                item.gambar,
                width: double.infinity,
                height: 300, // sedikit lebih tinggi biar proporsional
                fit: BoxFit.contain, // biar foto nggak kepotong
              ),
            ),
            const SizedBox(height: 25),
            Text(
              item.judul,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.penyanyi,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.pink.shade50,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "🎶 Song Information",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.pinkAccent,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Genre musik ini menggambarkan suasana hati yang lembut, penuh makna, "
                        "dan sarat emosi. Setiap nada dan liriknya menghadirkan nuansa ketenangan yang menembus perasaan pendengarnya, "
                        "menciptakan suasana reflektif dan menenangkan. Musik dengan karakter seperti ini sering kali digunakan untuk mengekspresikan perasaan mendalam, "
                        "seperti kerinduan, kasih sayang, dan ketenangan jiwa. Dengan irama yang lembut dan harmonis, "
                        "genre ini mampu menyentuh hati, membawa pendengarnya ke dalam suasana yang hangat, damai, "
                        "dan penuh ketulusan., "
                        "menunjukkan karakter musik yang menenangkan dan menyentuh hati.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.play_arrow, color: Colors.white),
              label: const Text(
                "Putar Lagu",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                padding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
