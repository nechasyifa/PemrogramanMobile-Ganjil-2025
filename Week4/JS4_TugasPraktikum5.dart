void main() {
  // Anonymous function dipakai langsung
  var angka = [1, 2, 3];
  angka.forEach((x) {
    print(x);
  });

  // Anonymous function disimpan ke variabel
  var kaliDua = (x) => x * 2;
  print(kaliDua(4));
}