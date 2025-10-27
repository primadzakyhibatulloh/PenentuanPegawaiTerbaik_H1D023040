🧮 Sistem Penilaian Pegawai (Dart Console App)
Proyek ini merupakan studi kasus sederhana penerapan dasar pemrograman Dart menggunakan kondisional if-else, perulangan, dan struktur data seperti List dan Map. Aplikasi berjalan di console (terminal) dan digunakan untuk menilai kinerja pegawai berdasarkan beberapa kriteria dengan bobot tertentu.
🚀 Fitur Utama
•	✅ Menu interaktif (looping sampai user keluar program)
•	✅ Input data pegawai dinamis
•	✅ Validasi nilai (harus 0–100 dan angka saja)
•	✅ Bobot kriteria yang bisa diubah oleh pengguna
•	✅ Otomatis menghitung skor total & kategori (A–E)
•	✅ Menentukan pegawai terbaik secara otomatis
•	✅ Sorting berdasarkan skor tertinggi


⚙️ Kriteria Penilaian Default
Kriteria	Bobot
Disiplin	0.25
Tanggung Jawab	0.20
Kerja Tim	0.20
Produktivitas	0.25
Inisiatif	0.10
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
🔹 Deklarasi class Pegawai
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

Map<String, double> nilai = {}; → menyimpan pasangan kriteria: nilai (mis. 'Disiplin': 85.0). Menggunakan Map agar jumlah kriteria bersifat dinamis.

double skorTotal = 0.0; → hasil perhitungan akhir (nilai berbobot).

String kategori = ''; → menyimpan hasil kategorisasi (A–E / deskripsi).

Pegawai(this.nama); → konstruktor untuk membuat objek Pegawai.
🔹 Fungsi main() — menu & flow utama
void main() { ... }

Penjelasan:
List<Pegawai> pegawaiList = []; → list pegawai.
Map<String, double> bobot = {...}; → bobot default.
while (true) { ... } → loop menu.
stdin.readLineSync() → membaca input user.
switch (pilihan) → navigasi menu.
exit(0) → keluar program.
🔹 tambahPegawai()
void tambahPegawai(List<Pegawai> list, Map<String, double> bobot) { ... }

Penjelasan:
Input nama pegawai, validasi nilai, simpan ke list utama.
🔹 inputNilaiValid()
double inputNilaiValid(String kriteria) { ... }

Fungsi loop sampai user memasukkan angka valid (0–100).
🔹 tampilPegawai()
void tampilPegawai(List<Pegawai> list) { ... }

Menampilkan daftar nama pegawai.
🔹 ubahBobot()
void ubahBobot(Map<String, double> bobot) { ... }

Mengubah bobot penilaian dan menormalkan total ke 1.0.
🔹 tampilLaporan()
void tampilLaporan(List<Pegawai> list, Map<String, double> bobot) { ... }

Menghitung skor total, menentukan kategori, sorting, dan menampilkan pegawai terbaik.
🔹 kategoriNilai()
String kategoriNilai(double skor) { ... }

Aturan kategorisasi nilai A–E berdasarkan skor total.
