import 'package:flutter/material.dart';
import '../models/item.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    final itemArgs = ModalRoute.of(context)!.settings.arguments as Item;

    String imagePath;
    String description;

    if (itemArgs.name.toLowerCase() == 'sugar') {
      imagePath = 'images/sugar.jpg';
      description =
          'Gula ini memiliki kualitas premium yang cocok untuk minuman dan makanan. '
          'Dikemas higienis dan siap digunakan untuk kebutuhan rumah tangga maupun usaha kuliner.';
    } else if (itemArgs.name.toLowerCase() == 'salt') {
      imagePath = 'images/salt.jpg';
      description =
          'Garam murni dengan cita rasa seimbang. Cocok untuk memasak berbagai hidangan dan menjaga cita rasa makanan Anda. '
          'Produk ini juga sudah melalui proses penyaringan yang baik.';
    } else {
      imagePath = 'images/default.jpg';
      description =
          'Produk ini merupakan bahan dapur yang sering digunakan sehari-hari. '
          'Kualitasnya terjaga dan cocok untuk kebutuhan rumah tangga maupun bisnis kuliner.';
    }

    Widget titleSection = Container(
      padding: const EdgeInsets.fromLTRB(32, 24, 32, 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    itemArgs.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Text(
                  'Price: Rp ${itemArgs.price}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.star, color: Colors.yellow),
          const SizedBox(width: 4),
          const Text('5'),
        ],
      ),
    );

    Widget textSection = Container(
      padding: const EdgeInsets.fromLTRB(32, 4, 32, 24),
      child: Text(
        description,
        style: const TextStyle(fontSize: 14, height: 1.4),
        softWrap: true,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Item'),
      ),
      body: ListView(
        children: [
          Image.asset(
            imagePath,
            width: 600,
            height: 240,
            fit: BoxFit.cover,
          ),
          titleSection,
          textSection,
        ],
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        color: const Color.fromARGB(255, 255, 191, 218),
        child: const Text(
          'Necha Syifa Syafitri - 2341720167',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(136, 54, 36, 23),
          ),
        ),
      ),
    );
  }
}