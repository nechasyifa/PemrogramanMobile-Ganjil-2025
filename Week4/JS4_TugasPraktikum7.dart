// List
List<String> getDataList() {
  return ["Necha", "2341720167"];
}

void main() {
  var data = getDataList();
  print("Nama: ${data[0]}, NIM: ${data[1]}");
}

// Map
Map<String, dynamic> getDataMap() {
  return {"nama": "Necha", "nim": 2341720167};
}

void main() {
  var data = getDataMap();
  print("Nama: ${data['nama']}, NIM: ${data['nim']}");
}

// Record
(String, int) getDataRecord() {
  return ("Necha", 2341720167);
}

void main() {
  var (nama, nim) = getDataRecord();
  print("Nama: $nama, NIM: $nim");
}