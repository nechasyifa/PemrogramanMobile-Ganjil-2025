void main() {
  // Lexical Scope
  var nama = "Necha";
  void sapa() {
    print("Halo $nama"); // Bisa akses variabel di luar (scope atas)
  }
  sapa();

  // Lexical Closure
  Function hitung() {
    var counter = 0;
    return () {
      counter++;
      print("Counter: $counter");
    };
  }

  var tambah = hitung();
  tambah();
  tambah();
}