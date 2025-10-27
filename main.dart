import 'dart:io';

class Pegawai {
  String nama;
  Map<String, double> nilai = {};
  double skorTotal = 0.0;
  String kategori = '';

  Pegawai(this.nama);
}

void main() {
  List<Pegawai> pegawaiList = [];
  Map<String, double> bobot = {
    'Disiplin': 0.25,
    'Tanggung Jawab': 0.20,
    'Kerja Tim': 0.20,
    'Produktivitas': 0.25,
    'Inisiatif': 0.10,
  };

  while (true) {
    print("\n=== SISTEM PENILAIAN PEGAWAI ===");
    print("1. Tambah Pegawai");
    print("2. Tampilkan Data Pegawai");
    print("3. Ubah Bobot Penilaian");
    print("4. Lihat Laporan Hasil");
    print("5. Keluar");
    stdout.write("Pilih menu (1-5): ");
    String? pilihan = stdin.readLineSync();

    switch (pilihan) {
      case '1':
        tambahPegawai(pegawaiList, bobot);
        break;
      case '2':
        tampilPegawai(pegawaiList);
        break;
      case '3':
        ubahBobot(bobot);
        break;
      case '4':
        tampilLaporan(pegawaiList, bobot);
        break;
      case '5':
        print("Terima kasih! Program selesai.");
        exit(0);
      default:
        print("Pilihan tidak valid!");
    }
  }
}

void tambahPegawai(List<Pegawai> list, Map<String, double> bobot) {
  stdout.write("\nNama Pegawai: ");
  String nama = stdin.readLineSync()!;
  Pegawai p = Pegawai(nama);

  for (var kriteria in bobot.keys) {
    double nilai = inputNilaiValid(kriteria);
    p.nilai[kriteria] = nilai;
  }

  list.add(p);
  print("✅ Pegawai '${p.nama}' berhasil ditambahkan!");
}

/// Fungsi validasi nilai input 0–100
double inputNilaiValid(String kriteria) {
  while (true) {
    stdout.write("Nilai $kriteria (0–100): ");
    String? input = stdin.readLineSync();

    try {
      double nilai = double.parse(input!);
      if (nilai < 0 || nilai > 100) {
        print("⚠️ Nilai harus antara 0 sampai 100. Coba lagi!");
      } else {
        return nilai;
      }
    } catch (e) {
      print("⚠️ Input tidak valid! Masukkan angka saja.");
    }
  }
}

void tampilPegawai(List<Pegawai> list) {
  if (list.isEmpty) {
    print("\nBelum ada data pegawai.");
    return;
  }

  print("\n=== DAFTAR PEGAWAI ===");
  for (var p in list) {
    print("- ${p.nama}");
  }
}

void ubahBobot(Map<String, double> bobot) {
  print("\n=== UBAH BOBOT PENILAIAN ===");
  for (var kriteria in bobot.keys) {
    stdout.write("Bobot baru untuk $kriteria (saat ini ${bobot[kriteria]}): ");
    double nilai = double.tryParse(stdin.readLineSync()!) ?? bobot[kriteria]!;
    bobot[kriteria] = nilai;
  }

  double total = bobot.values.reduce((a, b) => a + b);
  if (total != 1.0) {
    print("⚠️ Total bobot tidak sama dengan 1.0! Sistem akan menormalkan otomatis.");
    for (var key in bobot.keys) {
      bobot[key] = bobot[key]! / total;
    }
  }
  print("✅ Bobot berhasil diperbarui dan dinormalisasi!");
}

void tampilLaporan(List<Pegawai> list, Map<String, double> bobot) {
  if (list.isEmpty) {
    print("\nBelum ada data pegawai untuk dilaporkan.");
    return;
  }

  print("\n=== LAPORAN PENILAIAN PEGAWAI ===");
  print("--------------------------------------------------------------");
  print("Nama Pegawai       | Skor Akhir | Kategori");
  print("--------------------------------------------------------------");

  for (var p in list) {
    p.skorTotal = 0;
    bobot.forEach((kriteria, w) {
      p.skorTotal += (p.nilai[kriteria]! * w);
    });
    p.kategori = kategoriNilai(p.skorTotal);
  }

  list.sort((a, b) => b.skorTotal.compareTo(a.skorTotal));

  for (var p in list) {
    print("${p.nama.padRight(20)} | ${p.skorTotal.toStringAsFixed(2).padLeft(10)} | ${p.kategori}");
  }

  print("--------------------------------------------------------------");
  print("🏆 Pegawai Terbaik: ${list.first.nama} (${list.first.kategori})");
}

String kategoriNilai(double skor) {
  if (skor >= 90) return "A (Sangat Baik)";
  if (skor >= 80) return "B (Baik)";
  if (skor >= 70) return "C (Cukup)";
  if (skor >= 60) return "D (Kurang)";
  return "E (Buruk)";
}
