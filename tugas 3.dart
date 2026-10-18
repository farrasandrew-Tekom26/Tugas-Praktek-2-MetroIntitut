class Karakter {
  String nama;
  int _healthPoint = 100;

  Karakter({required this.nama});

  // Menampilkan salam karakter
  void sapa() {
    print('Halo, saya $nama, siap bertarung!');
  }

  // Getter untuk membaca sisa darah
  int get sisaDarah => _healthPoint;

  // Method untuk menerima serangan
  void terimaSerangan(int damage) {
    print('$nama diserang! Menerima $damage damage.');

    _healthPoint -= damage;

    if (_healthPoint <= 0) {
      _healthPoint = 0;
      print('$nama telah gugur.');
    } else {
      print('Sisa darah $nama: $_healthPoint');
    }
  }

  // Method untuk memulihkan darah
  void pulihkanDarah(int jumlah) {
    if (_healthPoint == 0) {
      print('$nama sudah gugur dan tidak bisa dipulihkan.');
      return;
    }

    _healthPoint += jumlah;

    if (_healthPoint > 100) {
      _healthPoint = 100;
    }

    print('Darah $nama pulih menjadi $_healthPoint.');
  }
}

// Class Healer mewarisi class Karakter
class Healer extends Karakter {
  Healer({required super.nama});

  // Method untuk menyembuhkan karakter lain
  void heal(Karakter target) {
    print('$nama merapal mantra penyembuh ke ${target.nama}!');
    target.pulihkanDarah(30);
  }
}

void main() {
  // Membuat objek karakter
  Karakter goblin = Karakter(nama: 'Goblin');
  Karakter layla = Karakter(nama: 'Layla');
  Healer estes = Healer(nama: 'Estes');

  print('=== PERTARUNGAN DIMULAI ===');

  // Karakter menyapa
  estes.sapa();
  layla.sapa();

  // Layla menerima serangan
  layla.terimaSerangan(50);

  // Estes menyembuhkan Layla dua kali
  estes.heal(layla);
  estes.heal(layla);

  // Goblin menerima dua serangan
  goblin.terimaSerangan(40);
  goblin.terimaSerangan(70);

  // Estes mencoba menyembuhkan Goblin
  estes.heal(goblin);

  // Memeriksa sisa darah Goblin
  print('Cek radar: darah Goblin tersisa ${goblin.sisaDarah}');
}
