void main() {
  var record = ('first', a: 2, b: true, 'last');
  print(record);
}

// Langkah 3
(int, int) tukar((int, int) record) {
  var (a, b) = record;
  return (b, a);
}