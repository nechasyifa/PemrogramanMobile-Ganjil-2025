// Positional Parameter (berdasarkan urutan)
// required positional
void halo(String nama, String hewan) {
  print("Halo, aku $nama, aku suka $hewan.");
}

// optional positional
void haloOpsional(String nama, [String? hewan]) {
  print("Halo, aku $nama, aku suka ${hewan ?? 'null'}.");
}

// default positional
void haloDefault(String nama, [String hewan = "kucing"]) {
  print("Halo, aku $nama, aku suka $hewan.");
}

void main() {
  halo("Necha", "kucing");          
  haloOpsional("Necha");      
  haloDefault("Necha");       
}

// Named Parameter (berdasarkan nama)
// required named
void mhs({required String nama, required int nim}) {
  print("Nama: $nama, NIM: $nim");
}

// optional named
void mhsOpsional({String? nama, int? nim}) {
  print("Nama: ${nama ?? 'Anonim'}, NIM: ${nim ?? 0}");
}

// default named
void mhsDefault({String nama = "Necha", int nim = 2341720167}) {
  print("Nama: $nama, NIM: $nim");
}

void main() {
  mhs(nama: "Necha", nim: 2341720167);   
  mhsOpsional(nama: "Necha");      
  mhsDefault();                    
}

// Function Parameter (isi parameternya berupa fungsi)
// higher-order function
void hitung(int a, int b, int Function(int, int) operasi) {
  print("Hasil: ${operasi(a, b)}");
}

void main() {
  // anonymous function
  hitung(5, 3, (x, y) => x + y);   
  hitung(5, 3, (x, y) => x * y);   
}

// Spread Parameter
void main() {
  var daftarGame = ["Roblox", "UpinIpin"];
  var semuaGame = ["Valo", ...daftarGame, "Pou"];

  print(semuaGame);
}