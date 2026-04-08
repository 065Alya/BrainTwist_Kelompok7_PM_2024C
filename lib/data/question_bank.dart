import '../models/question_model.dart';
import 'dart:math';

List<Question> questionBank = [

  // ================== MUDAH ==================
  Question("Apa yang ada di ujung langit?",
      ["Awan", "Matahari", "Huruf 't'", "Burung"], 2, "mudah"),

  Question("Jika 1kg batu dan 1kg kapas dijatuhkan ke kaki?",
      ["Batu", "Kapas", "Sama saja", "Kaki kita"], 3, "mudah"),

  Question("Siapa yang memotong rambut tiap hari tapi tidak botak?",
      ["Polisi", "Tukang cukur", "Guru", "Dokter"], 1, "mudah"),

  Question("Apa bedanya sepatu dengan jengkol?",
      ["Bentuk", "Warna", "Sepatu disemir, jengkol disemur", "Harga"], 2, "mudah"),

  Question("Apa yang dimiliki gajah tapi tidak dimiliki hewan lain?",
      ["Belalai", "Telinga besar", "Anak gajah", "Badan besar"], 2, "mudah"),

  Question("Apa yang selalu berada di tengah bumi?",
      ["Magma", "Batuan", "Huruf 'm'", "Inti"], 2, "mudah"),

  Question("Semakin banyak diambil semakin besar?",
      ["Uang", "Makanan", "Lubang", "Ember"], 2, "mudah"),

  Question("Apa yang bisa berlari tapi tidak punya kaki?",
      ["Mobil", "Air", "Angin", "Semua"], 1, "mudah"),

  Question("Ayam apa yang tidak bisa berkokok?",
      ["Ayam betina", "Ayam goreng", "Ayam kecil", "Ayam tua"], 1, "mudah"),

  Question("Apa yang semakin tua semakin muda?",
      ["Kakek", "Pohon", "Lilin", "Batu"], 2, "mudah"),

  // ================== SEDANG ==================
  Question("Aku selalu ada di atas presiden tapi tidak punya jabatan?",
      ["Mahkota", "Rambut", "Peci", "Topi"], 2, "sedang"),

  Question("Pintu apa didorong 7 orang tidak terbuka?",
      ["Besi", "Kayu", "Terkunci", "Geser"], 3, "sedang"),

  Question("Saat dibalik akan berkurang 3?",
      ["8", "7", "9", "6"], 2, "sedang"),

  Question("3 anak perempuan masing punya 1 adik laki-laki?",
      ["3", "2", "1", "4"], 2, "sedang"),

  Question("Apa yang punya 12 kaki dan bisa terbang?",
      ["12 ayam", "6 burung", "3 kucing", "2 elang"], 1, "sedang"),

  Question("Apa yang punya tangan tapi tidak bisa tepuk?",
      ["Orang", "Patung", "Jam", "Boneka"], 1, "sedang"),

  Question("Berapa kali bisa mengurangi 5 dari 25?",
      ["5", "Tak terbatas", "1", "2"], 2, "sedang"),

  Question("Dokter punya saudara laki-laki, tapi tidak sebaliknya?",
      ["Kembar", "Dokter perempuan", "Bohong", "Beda ibu"], 1, "sedang"),

  Question("Apa yang selalu ada di awal, tengah, akhir bulan?",
      ["Gajian", "Tagihan", "Huruf 'b'", "Tanggal"], 2, "sedang"),

  Question("Ayah punya 4 anak, siapa anak keempat?",
      ["Kamis", "Jumat", "Anak keempat", "Tidak tahu"], 2, "sedang"),

  // ================== SULIT ==================
  Question("Kenapa harus berhenti menuntut ilmu?",
      ["Capek", "Lulus", "Ilmu tidak salah", "Pintar"], 2, "sulit"),

  Question("Cara melipatgandakan uang?",
      ["Tabung", "Investasi", "Fotokopi", "Lipat"], 3, "sulit"),

  Question("Lemari apa bisa masuk kantong?",
      ["Kecil", "Plastik", "Lemaribuan", "Mini"], 2, "sulit"),

  Question("Ada 1x di semenit, 2x di momen, tidak ada di 1000 tahun?",
      ["Detik", "Keberuntungan", "Huruf 'm'", "Harapan"], 2, "sulit"),

  Question("Hewan paling kurang ajar?",
      ["Harimau", "Kucing", "Kutu rambut", "Tikus"], 2, "sulit"),

  Question("Aku bicara tanpa mulut, hidup saat angin?",
      ["Hantu", "Gema", "Angin", "Bayangan"], 1, "sulit"),

  Question("17 domba, semua kecuali 9 mati?",
      ["8", "17", "9", "0"], 2, "sulit"),

  Question("Menyalip orang ke-2, posisi?",
      ["1", "2", "3", "Terakhir"], 1, "sulit"),

  Question("3 apel, ambil 2, punya berapa?",
      ["1", "3", "2", "0"], 2, "sulit"),

  Question("Lebih besar dari Tuhan & mematikan jika dimakan?",
      ["Dosa", "Kemiskinan", "Tidak ada", "Keserakahan"], 2, "sulit"),
];


// ================== RANDOM FUNCTION ==================

List<Question> getRandomQuestions(String level) {
  final random = Random();

  List<Question> filtered =
  questionBank.where((q) => q.level == level).toList();

  filtered.shuffle(random);

  return filtered.take(10).toList(); // ambil 10 soal acak
}