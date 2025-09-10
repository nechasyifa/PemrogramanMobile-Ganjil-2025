void main() {
  int i = 0;
  String nama = "Necha Syifa Syafitri";
  String nim = "2341720167";

  bool isPrime;
  for (; i < 201; i++) {
    isPrime = true;

    if (i == 0 || i == 1) isPrime = false;

    for (int j = 2; j <= i / 2; j++) {
      if (i % j == 0) isPrime = false;
    }

    if (isPrime) {
      print('${i}');
    }
  }
  print("Nama : $nama");
  print("NIM  : $nim");
}
