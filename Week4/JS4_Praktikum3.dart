void main() {
  var gifts = {
    // Key:    Value
    'first': 'partridge',
    'second': 'turtledoves',
    'fifth': 1,
  };

  var nobleGases = {2: 'helium', 10: 'neon', 18: 2};

  //Langkah 3

  gifts['nama'] = 'Necha';
  gifts['nim'] = '2341720167';

  nobleGases[20] = 'Necha';
  nobleGases[21] = '2341720167';

  var mhs1 = Map<String, String>();
  mhs1['nama'] = 'Necha';
  mhs1['nim'] = '2341720167';

  var mhs2 = Map<int, String>();
  mhs2[1] = 'Necha';
  mhs2[2] = '2341720167';

  print("gifts: $gifts");
  print("nobleGases: $nobleGases");
  print("mhs1: $mhs1");
  print("mhs2: $mhs2");
}