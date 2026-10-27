import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DetailMenuPage(),
    );
  }
}

// =====================================================
// HALAMAN 1: DETAIL MENU KAFE
// =====================================================

class DetailMenuPage extends StatelessWidget {
  const DetailMenuPage({super.key});

  static const String imageUrl =
      'https://akcdn.detik.net.id/community/media/visual/2022/01/02/manfaat-kopi_169.jpeg?w=700&q=90';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Menu'),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),

      // Seluruh halaman dapat digulir
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tugas 1: Gambar menu
            Image.network(
              imageUrl,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 250,
                  color: Colors.brown.shade100,
                  child: const Center(child: Text('Gambar tidak dapat dimuat')),
                );
              },
            ),

            // Konten di bawah gambar menggunakan Padding 16
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tugas 2: Nama menu dan harga
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Expanded(
                        child: Text(
                          'Kopi Susu Gula Aren',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Rp 25.000',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Tugas 3: Kotak informasi menu
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.brown.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Informasi rating
                        Column(
                          children: [
                            Icon(Icons.star, color: Colors.orange, size: 28),
                            SizedBox(height: 6),
                            Text('4.9'),
                          ],
                        ),

                        // Informasi waktu
                        Column(
                          children: [
                            Icon(Icons.schedule, color: Colors.blue, size: 28),
                            SizedBox(height: 6),
                            Text('10 menit'),
                          ],
                        ),

                        // Informasi kalori
                        Column(
                          children: [
                            Icon(
                              Icons.local_fire_department,
                              color: Colors.red,
                              size: 28,
                            ),
                            SizedBox(height: 6),
                            Text('150 kal'),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Tugas 4: Judul deskripsi
                  const Text(
                    'Deskripsi',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  // Paragraf deskripsi menu
                  const Text(
                    'Kopi Susu Gula Aren merupakan perpaduan '
                    'kopi dengan susu yang lembut dan manisnya '
                    'gula aren. Minuman ini cocok dinikmati saat '
                    'bersantai maupun ketika beraktivitas.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 14, height: 1.5),
                  ),

                  const SizedBox(height: 16),

                  // Tugas 5: Tombol pesan sekarang
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),

                      // Membuka halaman ringkasan pesanan
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PesananMenuPage(),
                          ),
                        );
                      },

                      child: const Text(
                        'Pesan Sekarang',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Tambahan :
// =====================================================
// HALAMAN 2: RINGKASAN PESANAN
// =====================================================

class PesananMenuPage extends StatelessWidget {
  const PesananMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ringkasan Pesanan'),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pesanan Anda',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            // Kartu ringkasan produk
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    // Gambar produk
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        DetailMenuPage.imageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 100,
                            height: 100,
                            color: Colors.brown.shade100,
                            child: const Icon(Icons.coffee, size: 40),
                          );
                        },
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Nama, jumlah, dan harga
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kopi Susu Gula Aren',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text('Jumlah: 1 item'),
                          SizedBox(height: 8),
                          Text(
                            'Rp 25.000',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Rincian total pembayaran
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Pesanan', style: TextStyle(fontSize: 16)),
                Text(
                  'Rp 25.000',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const Spacer(),

            // Tombol konfirmasi pesanan
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (dialogContext) {
                      return AlertDialog(
                        title: const Text('Pesanan Berhasil'),
                        content: const Text(
                          'Kopi Susu Gula Aren berhasil '
                          'dikonfirmasi. Terima kasih '
                          'telah memesan!',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(dialogContext);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },

                child: const Text(
                  'Konfirmasi Pesanan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Tombol kembali ke detail menu
            SizedBox(
              width: double.infinity,
              height: 45,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Kembali ke Detail Menu'),
              ),
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
