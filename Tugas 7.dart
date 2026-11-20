import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const Color warnaCokelat = Color(0xFF795548);
const Color warnaLatar = Color(0xFFFFF8FC);

void main() {
  runApp(const CafeApp());
}

class MenuKafe {
  final String nama;
  final String gambar;
  final int harga;
  final String deskripsi;
  final double rating;
  final int waktu;
  final int kalori;

  const MenuKafe({
    required this.nama,
    required this.gambar,
    required this.harga,
    required this.deskripsi,
    required this.rating,
    required this.waktu,
    required this.kalori,
  });

  factory MenuKafe.fromJson(Map<String, dynamic> json) {
    final List bahan = json['ingredients'] is List ? json['ingredients'] : [];

    final int kaloriPerSajian =
        (json['caloriesPerServing'] as num?)?.toInt() ?? 250;

    return MenuKafe(
      nama: json['name']?.toString() ?? 'Tanpa Nama',
      gambar: json['image']?.toString() ?? '',
      harga: kaloriPerSajian * 100,
      deskripsi: bahan.isNotEmpty
          ? bahan.map((item) => item.toString()).join(', ')
          : 'Menu spesial',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      waktu: (json['cookTimeMinutes'] as num?)?.toInt() ?? 10,
      kalori: kaloriPerSajian,
    );
  }
}

class MenuViewModel extends ChangeNotifier {
  List<MenuKafe> menus = [];

  bool isLoading = false;
  String? errorMessage;

  bool isFavorite = false;
  int jumlahPorsi = 1;

  MenuKafe? menuDipilih;

  int get totalHarga => (menuDipilih?.harga ?? 0) * jumlahPorsi;

  Future<void> fetchMenus() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await http
          .get(Uri.parse('https://dummyjson.com/recipes'))
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List recipes = data['recipes'] ?? [];

        menus = recipes.map((item) {
          return MenuKafe.fromJson(Map<String, dynamic>.from(item));
        }).toList();

        if (menus.isEmpty) {
          errorMessage = 'Data menu belum tersedia.';
        }
      } else {
        menus = [];
        errorMessage = 'Gagal mengambil data. Kode: ${response.statusCode}';
      }
    } catch (e) {
      menus = [];
      errorMessage = 'Tidak dapat memuat menu. Periksa koneksi internet Anda.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void pilihMenu(MenuKafe menu) {
    menuDipilih = menu;
    jumlahPorsi = 1;
    isFavorite = false;
    notifyListeners();
  }

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  void tambahPorsi() {
    jumlahPorsi++;
    notifyListeners();
  }

  void kurangPorsi() {
    if (jumlahPorsi > 1) {
      jumlahPorsi--;
      notifyListeners();
    }
  }
}

class CafeApp extends StatelessWidget {
  const CafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katalog Menu Kafe',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: warnaLatar,
        useMaterial3: true,
      ),
      home: const DaftarMenuView(),
    );
  }
}

class DaftarMenuView extends StatefulWidget {
  const DaftarMenuView({super.key});

  @override
  State<DaftarMenuView> createState() => _DaftarMenuViewState();
}

class _DaftarMenuViewState extends State<DaftarMenuView> {
  late final MenuViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = MenuViewModel();
    viewModel.fetchMenus();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Menu Kafe',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: warnaCokelat,
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, child) {
          if (viewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: warnaCokelat),
            );
          }

          if (viewModel.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.wifi_off, size: 65, color: Colors.red),
                    const SizedBox(height: 15),
                    Text(viewModel.errorMessage!, textAlign: TextAlign.center),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: viewModel.fetchMenus,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Coba Lagi'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: warnaCokelat,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (viewModel.menus.isEmpty) {
            return const Center(child: Text('Belum ada menu tersedia.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: viewModel.menus.length,
            itemBuilder: (context, index) {
              final menu = viewModel.menus[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 14),
                elevation: 3,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      menu.gambar,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 70,
                          height: 70,
                          color: Colors.brown.shade100,
                          child: const Icon(
                            Icons.local_cafe,
                            color: warnaCokelat,
                          ),
                        );
                      },
                    ),
                  ),
                  title: Text(
                    menu.nama,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Rp ${menu.harga}',
                    style: const TextStyle(
                      color: warnaCokelat,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 17,
                    color: warnaCokelat,
                  ),
                  onTap: () {
                    viewModel.pilihMenu(menu);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailMenuView(menu: menu, viewModel: viewModel),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DetailMenuView extends StatelessWidget {
  final MenuKafe menu;
  final MenuViewModel viewModel;

  const DetailMenuView({
    super.key,
    required this.menu,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Menu'),
        backgroundColor: warnaCokelat,
        foregroundColor: Colors.white,
        actions: [
          ListenableBuilder(
            listenable: viewModel,
            builder: (context, child) {
              return IconButton(
                onPressed: viewModel.toggleFavorite,
                icon: Icon(
                  viewModel.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: viewModel.isFavorite ? Colors.red : Colors.white,
                ),
              );
            },
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  menu.gambar,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 250,
                      color: Colors.brown.shade100,
                      child: const Icon(
                        Icons.local_cafe,
                        size: 80,
                        color: warnaCokelat,
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              menu.nama,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            'Rp ${menu.harga}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: warnaCokelat,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.brown.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const Icon(Icons.star, color: Colors.orange),
                                Text(menu.rating.toStringAsFixed(1)),
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(Icons.schedule, color: Colors.blue),
                                Text('${menu.waktu} menit'),
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(
                                  Icons.local_fire_department,
                                  color: Colors.red,
                                ),
                                Text('${menu.kalori} kal'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Atur Porsi',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: viewModel.kurangPorsi,
                                icon: const Icon(
                                  Icons.remove_circle_outline,
                                  color: warnaCokelat,
                                ),
                              ),
                              Text(
                                '${viewModel.jumlahPorsi}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                              IconButton(
                                onPressed: viewModel.tambahPorsi,
                                icon: const Icon(
                                  Icons.add_circle_outline,
                                  color: warnaCokelat,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Deskripsi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        menu.deskripsi,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontSize: 14, height: 1.5),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: warnaCokelat,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PesananMenuView(
                                  menu: menu,
                                  jumlah: viewModel.jumlahPorsi,
                                  total: viewModel.totalHarga,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Pesan Sekarang',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class PesananMenuView extends StatelessWidget {
  final MenuKafe menu;
  final int jumlah;
  final int total;

  const PesananMenuView({
    super.key,
    required this.menu,
    required this.jumlah,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ringkasan Pesanan'),
        backgroundColor: warnaCokelat,
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
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        menu.gambar,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 100,
                            height: 100,
                            color: Colors.brown.shade100,
                            child: const Icon(
                              Icons.local_cafe,
                              size: 40,
                              color: warnaCokelat,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            menu.nama,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('Jumlah: $jumlah item'),
                          const SizedBox(height: 8),
                          Text('Rp ${menu.harga}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Pesanan'),
                Text(
                  'Rp $total',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: warnaCokelat,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (dialogContext) {
                      return AlertDialog(
                        title: const Text('Pesanan Berhasil'),
                        content: Text(
                          '${menu.nama} sebanyak $jumlah porsi '
                          'berhasil dikonfirmasi. '
                          'Total pembayaran Rp $total. '
                          'Terima kasih telah memesan!',
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
                child: const Text('Konfirmasi Pesanan'),
              ),
            ),
            const SizedBox(height: 12),
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
          ],
        ),
      ),
    );
  }
}
