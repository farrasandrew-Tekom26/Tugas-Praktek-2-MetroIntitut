import 'package:flutter/material.dart';

void main() {
  runApp(const CafeApp());
}

const Color warnaCokelat = Color(0xFF795548);
const Color warnaLatar = Color(0xFFFFF8FC);

class CafeApp extends StatelessWidget {
  const CafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Detail Menu Kafe',
      theme: ThemeData(scaffoldBackgroundColor: warnaLatar, useMaterial3: true),
      home: const HalamanPertama(),
    );
  }
}

class HalamanPertama extends StatelessWidget {
  const HalamanPertama({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: warnaLatar,
        title: const Text(
          'Detail Menu',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://images.alodokter.com/dk0z4ums3/image/upload/v1594099343/attached_image/ini-manfaat-konsumsi-kopi-hitam-dan-efek-sampingnya-untuk-kesehatan-0-alodokter.jpg',
              width: double.infinity,
              height: 180,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 180,
                  color: Colors.brown.shade100,
                  child: const Icon(
                    Icons.local_cafe,
                    size: 70,
                    color: warnaCokelat,
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Kopi Susu Gula Aren',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Rp 25.000',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: warnaCokelat,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    color: Colors.brown.shade50,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.star, color: Colors.amber),
                            Text('4.9'),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.access_time, color: warnaCokelat),
                            Text('10 menit'),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.local_fire_department,
                              color: Colors.deepOrange,
                            ),
                            Text('150 kal'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Deskripsi',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Perpaduan espresso, susu segar, dan gula aren asli. '
                    'Rasanya manis legit dengan aroma karamel. '
                    'Paling enak diminum dingin di siang hari.',
                    style: TextStyle(fontSize: 14, height: 1.5),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HalamanKedua(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: warnaCokelat,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Pesan Sekarang',
                        style: TextStyle(fontWeight: FontWeight.bold),
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

class HalamanKedua extends StatefulWidget {
  const HalamanKedua({super.key});

  @override
  State<HalamanKedua> createState() => _HalamanKeduaState();
}

class _HalamanKeduaState extends State<HalamanKedua> {
  bool isFavorite = false;
  int jumlahPesanan = 1;
  String catatanPesanan = '';

  final int hargaSatuan = 25000;

  int get totalHarga => hargaSatuan * jumlahPesanan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: warnaCokelat,
        foregroundColor: Colors.white,
        title: const Text(
          'Detail Menu',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://wiratech.co.id/wp-content/uploads/2018/09/cara-membuat-kopi-enak.jpg',
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 150,
                  color: Colors.brown.shade100,
                  child: const Icon(
                    Icons.local_cafe,
                    size: 70,
                    color: warnaCokelat,
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          'Kopi Susu Gula Aren',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        'Rp ${hargaSatuan.toString()}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: warnaCokelat,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.brown.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 17),
                            SizedBox(width: 4),
                            Text('4.9'),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: warnaCokelat,
                              size: 17,
                            ),
                            SizedBox(width: 4),
                            Text('10 Menit'),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.local_fire_department,
                              color: Colors.orange,
                              size: 17,
                            ),
                            SizedBox(width: 4),
                            Text('150 Kal'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Atur Porsi',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (jumlahPesanan > 1) {
                                  jumlahPesanan--;
                                }
                              });
                            },
                            icon: const Icon(
                              Icons.remove_circle_outline,
                              color: warnaCokelat,
                            ),
                          ),
                          Text(
                            '$jumlahPesanan',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                jumlahPesanan++;
                              });
                            },
                            icon: const Icon(
                              Icons.add_circle_outline,
                              color: warnaCokelat,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Deskripsi',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Perpaduan sempurna antara biji kopi espresso '
                    'pilihan dari dataran tinggi dengan susu segar '
                    'full cream dan manis legitnya gula aren organik '
                    'asli. Cocok menemani waktu santai maupun saat '
                    'fokus bekerja sehari-harian.',
                    style: TextStyle(fontSize: 13, height: 1.5),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Catatan untuk Barista (Opsional)',
                      hintText: 'Less Sugar',
                      prefixIcon: const Icon(Icons.edit_note),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        catatanPesanan = value;
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Catatan: "${catatanPesanan.isEmpty ? 'Belum ada catatan' : catatanPesanan}"',
                    style: const TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Pesanan $jumlahPesanan porsi berhasil. '
                              'Total Rp $totalHarga',
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: warnaCokelat,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Pesan Sekarang (Rp $totalHarga)',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
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
