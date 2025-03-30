import 'package:flutter/material.dart';
import 'cart_screen.dart';

class CatalogScreen extends StatefulWidget {
  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final Map<String, List<Map<String, dynamic>>> categories = {
    'Молоко': [
      {'name': 'Молоко 3.2%', 'price': '89 ₽', 'oldPrice': '99 ₽', 'image': 'assets/images/milk_3.2.png'},
      {'name': 'Молоко 2.5%', 'price': '85 ₽', 'oldPrice': null, 'image': 'assets/images/milk_2.5.png'},
      {'name': 'Молоко 1.5%', 'price': '80 ₽', 'oldPrice': '90 ₽', 'image': 'assets/images/milk_1.5.png'},
    ],
    'Хлеб': [
      {'name': 'Хлеб белый', 'price': '45 ₽', 'oldPrice': null, 'image': 'assets/images/bread_white.png'},
      {'name': 'Хлеб ржаной', 'price': '55 ₽', 'oldPrice': '65 ₽', 'image': 'assets/images/bread_rye.png'},
      {'name': 'Багет', 'price': '60 ₽', 'oldPrice': null, 'image': 'assets/images/baguette.png'},
    ],
    'Фрукты': [
      {'name': 'Яблоки сезонные', 'price': '129 ₽', 'oldPrice': '149 ₽', 'image': 'assets/images/apples.png'},
      {'name': 'Бананы', 'price': '99 ₽', 'oldPrice': null, 'image': 'assets/images/bananas.png'},
    ],
    'Мясо': [
      {'name': 'Куриное филе', 'price': '299 ₽', 'oldPrice': null, 'image': 'assets/images/chicken.png'},
      {'name': 'Свинина', 'price': '350 ₽', 'oldPrice': '400 ₽', 'image': 'assets/images/pork.png'},
    ],
  };

  List<Map<String, dynamic>> cartItems = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF00A1D6),
          elevation: 0,
          title: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              'Каталог',
              style: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartScreen(cartItems: cartItems)),
                    );
                  },
                ),
                if (cartItems.isNotEmpty)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '${cartItems.length}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            labelColor: Color(0xFFFFFFFF),
            unselectedLabelColor: Color(0xFFB0E0F6),
            indicatorColor: Color(0xFFFFFFFF),
            tabs: categories.keys.map((category) => Tab(text: category)).toList(),
          ),
        ),
        body: TabBarView(
          children: categories.entries.map((entry) {
            final products = entry.value;
            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 8), // Исправлено на "bottom"
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(
                            product['image'],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(color: Color(0xFFE0E0E0));
                            },
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name'],
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    product['price'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF00A1D6),
                                      fontWeight: FontWeight.bold),
                                  ),
                                  if (product['oldPrice'] != null) ...[
                                    SizedBox(width: 8),
                                    Text(
                                      product['oldPrice'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              cartItems.add(Map.from(product));
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${product['name']} добавлен в корзину')),
                            );
                          },
                          child: Text('В корзину'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(100, 36),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}