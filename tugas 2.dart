// Langkah 3: Function hitungTotal (di luar main)
int hitungTotal(List<int> harga) {
  int total = 0;
  for (int h in harga) {
    total += h;
  }
  return total;
}

// Langkah 4: Function hitungPajak menggunakan arrow function (di luar main)
double hitungPajak(double total) => total * 10 / 100;

void main() {
  // Langkah 1: Deklarasi Data Toko & Pelanggan
  const String namaToko = 'Toko Metro';
  final String namaPelanggan = 'Budi';
  bool isMember = true;
  String? kodeVoucher;

  // Langkah 2: Deklarasi Daftar Barang
  List<String> namaBarang = ['Pensil', 'Buku', 'Tas'];
  List<int> hargaBarang = [5000, 15000, 120000];

  // Langkah 5: Hitung Total Belanja
  int total = hitungTotal(hargaBarang);

  // Langkah 6: Tentukan Diskon dengan if
  double diskon = 0;
  if (isMember && total >= 100000) {
    diskon = total * 10 / 100;
  }

  // Langkah 7: Hitung Pajak, Bayar, dan Kembalian
  double pajak = hitungPajak(total - diskon);
  double bayar = total - diskon + pajak;
  double uangBayar = 200000;
  double kembalian = uangBayar - bayar;

  // Langkah 8: Tentukan Level Pelanggan dengan switch
  String level;
  switch (total) {
    case >= 200000:
      level = 'Gold';
      break;
    case >= 100000:
      level = 'Silver';
      break;
    default:
      level = 'Reguler';
  }

  // Langkah 9: Cetak Struk
  print('=== $namaToko ===');
  print('Pelanggan: $namaPelanggan');

  for (int i = 0; i < namaBarang.length; i++) {
    print('${i + 1}. ${namaBarang[i]}  Rp ${hargaBarang[i]}');
  }

  print('Total\t  : Rp $total');
  print('Diskon\t  : Rp $diskon');
  print('Pajak\t  : Rp $pajak');
  print('Bayar\t  : Rp $bayar');
  print('Voucher   : ${kodeVoucher ?? 'Tidak ada voucher'}');
  print('Level\t  : $level');
  print('Kembalian : Rp $kembalian');
}