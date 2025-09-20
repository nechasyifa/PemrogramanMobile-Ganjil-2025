void sapa(String hewan) {
  print("Halo $hewan");
}

void main() {
  // Simpan fungsi dalam variabel
  var fungsiSapa = sapa;
  fungsiSapa("Kucing");  

  // Kirim fungsi sebagai parameter
  void jalankan(void Function(String) f) {
    f("Miaw");
  }
  jalankan(sapa);
}