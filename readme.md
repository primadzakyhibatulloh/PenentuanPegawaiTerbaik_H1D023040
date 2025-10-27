🧮 Sistem Penilaian Pegawai (Dart Console App)

Proyek ini merupakan studi kasus sederhana penerapan dasar pemrograman Dart menggunakan kondisional if-else, perulangan, dan struktur data seperti List dan Map.
Aplikasi berjalan di console (terminal) dan digunakan untuk menilai kinerja pegawai berdasarkan beberapa kriteria dengan bobot tertentu.

🚀 Fitur Utama

✅ Menu interaktif (looping sampai user keluar program)
✅ Input data pegawai dinamis
✅ Validasi nilai (harus 0–100 dan angka saja)
✅ Bobot kriteria yang bisa diubah oleh pengguna
✅ Otomatis menghitung skor total & kategori (A–E)
✅ Menentukan pegawai terbaik secara otomatis
✅ Sorting berdasarkan skor tertinggi

⚙️ Kriteria Penilaian Default
| Kriteria       | Bobot |
| -------------- | ----- |
| Disiplin       | 0.25  |
| Tanggung Jawab | 0.20  |
| Kerja Tim      | 0.20  |
| Produktivitas  | 0.25  |
| Inisiatif      | 0.10  |
Total bobot otomatis dinormalisasi agar berjumlah 1.0

🧩 Cara Menjalankan Program
1️⃣ Pastikan Dart SDK sudah terinstal
Cek versi:
dart --version

2️⃣ Jalankan program di terminal (Sesuaikan nama file nya):
dart run penilaian_pegawai.dart

3️⃣ Atau kompilasi menjadi file .exe:
dart compile exe penilaian_pegawai.dart -o penilaian_pegawai.exe
./penilaian_pegawai.exe

🔎 Penjelasan Kode — Detail Lengkap

1) Deklarasi class Pegawai
class Pegawai {
  String nama;
  Map<String, double> nilai = {};
  double skorTotal = 0.0;
  String kategori = '';

  Pegawai(this.nama);
}


Penjelasan:

class Pegawai → mendefinisikan tipe data untuk menyimpan data tiap pegawai.
String nama; → properti untuk menyimpan nama pegawai.
Map<String, double> nilai = {}; → menyimpan pasangan kriteria: nilai (mis. "Disiplin": 85.0). Menggunakan Map agar jumlah kriteria bersifat dinamis sesuai bobot yang dipakai.
double skorTotal = 0.0; → menyimpan hasil perhitungan akhir (nilai berbobot) — diisi saat pembuatan laporan.
String kategori = ''; → menyimpan hasil kategorisasi (A–E / deskripsi).
Pegawai(this.nama); → konstruktor singkat untuk membuat objek Pegawai dengan nama.


2) Fungsi main() — menu & flow utama
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


Penjelasan:

List<Pegawai> pegawaiList = []; → list untuk menampung seluruh objek pegawai selama runtime program.
Map<String, double> bobot = { ... }; → bobot default per kriteria. Nilai yang dijadikan bobot harus di-normalisasi agar total = 1.0 (sistem kita menormalkan otomatis pada fungsi ubahBobot).
while (true) { ... } → loop tak-habis (menu terus muncul sampai user pilih 'Keluar'). Ini pola umum pada aplikasi console menu-driven.
stdin.readLineSync() → membaca input baris dari user. Hati-hati: bisa null jika EOF — di program ini kita tidak menangani EOF eksplisit.
switch (pilihan) → routing pilihan menu ke fungsi terkait.
exit(0) → keluar program secara eksplisit.


3) tambahPegawai() — input data pegawai + validasi
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


Penjelasan baris-per-baris:

stdout.write("\nNama Pegawai: "); → menampilkan prompt tanpa baris baru akhir.
String nama = stdin.readLineSync()!; → baca nama. Tanda ! memaksa non-null; ini asumsinya user akan memasukkan sesuatu. Lebih aman gunakan null-check atau default trimming.
Pegawai p = Pegawai(nama); → buat objek baru.
for (var kriteria in bobot.keys) { ... } → iterasi semua kriteria berdasarkan bobot saat ini — ini memastikan field nilai konsisten dengan bobot.
double nilai = inputNilaiValid(kriteria); → memanggil fungsi validasi yang memastikan nilai numeric dan di rentang 0–100.
p.nilai[kriteria] = nilai; → simpan nilai di Map objek pegawai.
list.add(p); → tambahkan ke list utama.


4) inputNilaiValid() — validasi robust untuk nilai 0–100
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


cara kerja:
Fungsi ini loop sampai user memasukkan angka valid.
double.parse(input!) → konversi string ke double; ! memaksa non-null (bila null maka exception).
try/catch → menangkap FormatException jika input bukan angka (mis. 'abc') atau null.
Pemeriksaan range if (nilai < 0 || nilai > 100) memastikan input dalam batas.
Jika valid → return nilai; keluar dari loop dan fungsi.


5) tampilPegawai() — menampilkan daftar nama (simple)
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

Fungsi :
Menampilkan ringkasan cepat, berguna untuk verifikasi data sebelum menampilkan laporan.
Bisa dikembangkan menjadi menampilkan detail nilai tiap kriteria (opsional).


6) ubahBobot() — mengubah bobot & normalisasi
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


Penjelasan penting:

Untuk setiap kriteria, user diminta masukkan bobot baru.
double.tryParse(...) ?? bobot[kriteria]! → jika parse gagal (mis. input kosong atau bukan angka), gunakan bobot lama.
Setelah input semua bobot, total bobot dihitung. Jika tidak sama 1.0, kita normalisasi dengan membagi tiap bobot dengan total. Setelah normalisasi, jumlah bobot = 1.0.
Normalisasi memastikan perhitungan skor berbobot tetap konsisten.


7) tampilLaporan() — menghitung skor, kategori, sort, dan tampil
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


Detail langkah:
Periksa apakah ada data.

Untuk setiap pegawai:

Set p.skorTotal = 0; agar perhitungan bersih tiap kali laporan dibuat.
bobot.forEach((kriteria, w) { p.skorTotal += (p.nilai[kriteria]! * w); });
Ambil nilai pegawai untuk tiap kriteria dan kalikan dengan bobot, lalu jumlahkan.
p.nilai[kriteria]! memakai ! karena kode mengasumsikan nilai pasti ada (karena saat tambahPegawai kita mengisi semua kriteria dari bobot.keys). Ini aman jika struktur konsisten; bila ada mismatch, akan terjadi null error.
p.kategori = kategoriNilai(p.skorTotal); → tentukan grade/deskripsi.
list.sort((a, b) => b.skorTotal.compareTo(a.skorTotal)); → urut menurun berdasarkan skor.
Tampilkan tabel dan pegawai terbaik.


8) kategoriNilai() — aturan kategorisasi
String kategoriNilai(double skor) {
  if (skor >= 90) return "A (Sangat Baik)";
  if (skor >= 80) return "B (Baik)";
  if (skor >= 70) return "C (Cukup)";
  if (skor >= 60) return "D (Kurang)";
  return "E (Buruk)";
}


Penjelasan:

Sederhana: rentang 0–100 dipecah ke lima grade.
Pastikan range mencakup seluruh kemungkinan (skor bisa decimal, fungsi cocok).
Jika suatu saat kamu ingin grade berbasis percentiles atau adaptif, logika ini harus diganti.