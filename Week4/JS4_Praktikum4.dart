void main() {
  var list = [1, 2, 3];
  var list2 = [0, ...list];
  print(list);
  print(list2);
  print(list2.length);

  // Langkah 3
  var list1 = [1, 2, null];
  print(list1);
  var list3 = [0, ...?list1];
  print(list3.length);

  // Spread Operators
  var NIM = [2, 3, 4, 1, 7, 2, 0, 1, 6, 7];
  var NIMlist = [...NIM];

  print("NIM: $NIMlist");

  // Langkah 4
  bool promoActive = true;
  var nav1 = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];
  print(nav1);

  promoActive = false;
  var nav2 = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];
  print(nav2);
}